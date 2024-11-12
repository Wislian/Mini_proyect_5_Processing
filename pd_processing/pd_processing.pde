import oscP5.*;
import netP5.*;
import java.util.ArrayList;

OscP5 oscP5;
NetAddress destino;

BolaPrincipal bolaPrincipal;
ArrayList<BolaSecundaria> bolasSecundarias;
int puntaje;
int tiempoInicio;
boolean juegoActivo;

void setup() {
    size(800, 600);
    
    // Inicializar OSC
    oscP5 = new OscP5(this, 12000);
    destino = new NetAddress("127.0.0.1", 8000);
    
    iniciarJuego();
}

void iniciarJuego() {
    puntaje = 0;
    tiempoInicio = millis();
    juegoActivo = true;
    
    // Crear bola principal en el centro con número inicial 1
    bolaPrincipal = new BolaPrincipal(width/2, height/2, "curvilineo", 1);
    
    // Inicializar bolas secundarias
    bolasSecundarias = new ArrayList<>();
    for (int i = 2; i <= 9; i++) {  // Cambiamos el rango para que empiece desde 2
        float posX = random(50, width-50);
        float posY = random(50, height-50);
        String movimiento = obtenerMovimientoAleatorio();
        bolasSecundarias.add(new BolaSecundaria(posX, posY, i, movimiento));
    }
}

String obtenerMovimientoAleatorio() {
    String[] movimientos = {"curvilineo", "triangular", "rectangular"};
    return movimientos[int(random(movimientos.length))];
}

void draw() {
    background(240);
    mostrarInfoJuego();
    
    bolaPrincipal.mover(mouseX, mouseY);
    bolaPrincipal.mostrar();
    
    for (BolaSecundaria bola : bolasSecundarias) {
        bola.mostrar();
        if (detectarColision(bolaPrincipal, bola)) {
            manejarColision(bola);
        }
    }
    
    // Enviar datos OSC del movimiento
    enviarDatosMovimiento();
}

void mostrarInfoJuego() {
    fill(50);
    textSize(16);
    text("Puntaje: " + puntaje, 20, 30);
    text("Tiempo: " + ((millis() - tiempoInicio) / 1000) + "s", 20, 55);
    text("Movimiento: " + bolaPrincipal.movimiento, 20, 80);
    text("Número: " + bolaPrincipal.numero, 20, 105);
}

class BolaPrincipal {
    float x, y;
    String movimiento;
    int numero;
    ArrayList<PVector> estela;
    float velocidad;
    
    BolaPrincipal(float x, float y, String movimiento, int numero) {
        this.x = x;
        this.y = y;
        this.movimiento = movimiento;
        this.numero = numero;
        this.estela = new ArrayList<>();
        this.velocidad = 0.05;
    }
    
    void mover(float targetX, float targetY) {
        float dx = targetX - x;
        float dy = targetY - y;
        
        switch(movimiento) {
            case "curvilineo":
                x += dx * velocidad;
                y += dy * velocidad;
                break;
            case "triangular":
                if (abs(dx) > 5) {
                    x += dx * velocidad * 1.5;
                }
                if (abs(dy) > 5) {
                    y += dy * velocidad * 1.5;
                }
                break;
            case "rectangular":
                if (abs(dx) > abs(dy)) {
                    x += dx * velocidad * 2;
                } else {
                    y += dy * velocidad * 2;
                }
                break;
        }
        
        // Actualizar estela
        estela.add(new PVector(x, y));
        if (estela.size() > 20) estela.remove(0);
    }
    
    void mostrar() {
        // Dibujar estela
        noFill();
        stroke(100, 100, 255, 100);
        beginShape();
        for (PVector p : estela) {
            vertex(p.x, p.y);
        }
        endShape();
        
        // Dibujar bola principal
        fill(100, 100, 255);
        stroke(50, 50, 200);
        ellipse(x, y, 40, 40);
        
        // Mostrar número
        fill(255);
        textAlign(CENTER, CENTER);
        textSize(16);
        text(numero, x, y);
    }
}

class BolaSecundaria {
    float x, y;
    int numero;
    String movimiento;
    float anguloVerde, anguloRojo;
    float velocidadRotacion;
    
    BolaSecundaria(float x, float y, int numero, String movimiento) {
        this.x = x;
        this.y = y;
        this.numero = numero;
        this.movimiento = movimiento;
        this.anguloVerde = 0;
        this.anguloRojo = 180;
        this.velocidadRotacion = random(1, 3);
    }
    
    void mostrar() {
        // Dibujar bola base
        fill(220);
        stroke(150);
        ellipse(x, y, 40, 40);
        
        // Dibujar arcos rotatorios
        noFill();
        strokeWeight(3);
        
        // Arco verde (lado izquierdo)
        stroke(0, 255, 0, 200);
        arc(x, y, 50, 50, radians(anguloVerde), radians(anguloVerde + 180));
        
        // Arco rojo (lado derecho)
        stroke(255, 0, 0, 200);
        arc(x, y, 50, 50, radians(anguloRojo), radians(anguloRojo + 180));
        
        // Actualizar rotación
        anguloVerde = (anguloVerde + velocidadRotacion) % 360;
        anguloRojo = (anguloRojo + velocidadRotacion) % 360;
        
        // Mostrar número
        fill(50);
        textAlign(CENTER, CENTER);
        textSize(16);
        text(numero, x, y);
        
        strokeWeight(1);
    }
}

boolean detectarColision(BolaPrincipal bola1, BolaSecundaria bola2) {
    return dist(bola1.x, bola1.y, bola2.x, bola2.y) < 40;
}

void manejarColision(BolaSecundaria bolaSecundaria) {
    // Calcular el ángulo entre las bolas
    float angulo = degrees(atan2(bolaPrincipal.y - bolaSecundaria.y, 
                                bolaPrincipal.x - bolaSecundaria.x));
    
    // Normalizar el ángulo entre 0 y 360 grados
    while (angulo < 0) angulo += 360;
    
    // Determinar si la colisión fue en el lado verde o rojo
    boolean estaEnLadoVerde = false;
    float anguloNormalizado = (angulo - bolaSecundaria.anguloVerde + 360) % 360;
    if (anguloNormalizado <= 180) {
        estaEnLadoVerde = true;
    }
    
    // Verificar si la colisión es válida
    boolean colisionValida = false;
    if (estaEnLadoVerde && bolaPrincipal.numero < bolaSecundaria.numero) {
        colisionValida = true;
    } else if (!estaEnLadoVerde && bolaPrincipal.numero > bolaSecundaria.numero) {
        colisionValida = true;
    }
    
    if (colisionValida) {
        // Actualizar la bola principal
        bolaPrincipal.numero = bolaSecundaria.numero;
        bolaPrincipal.movimiento = bolaSecundaria.movimiento;
        puntaje += 100;
        
        // Enviar mensaje OSC de colisión exitosa
        enviarMensajeColision("colision_exitosa");
        
        // Reposicionar la bola secundaria
        bolaSecundaria.x = random(50, width-50);
        bolaSecundaria.y = random(50, height-50);
        bolaSecundaria.movimiento = obtenerMovimientoAleatorio();
    }
}

void enviarDatosMovimiento() {
    OscMessage msg = new OscMessage("/movimiento");
    msg.add(bolaPrincipal.x / width);
    msg.add(bolaPrincipal.y / height);
    msg.add(bolaPrincipal.movimiento);
    oscP5.send(msg, destino);
}

void enviarMensajeColision(String tipo) {
    OscMessage msg = new OscMessage("/" + tipo);
    msg.add(1);
    oscP5.send(msg, destino);
}
