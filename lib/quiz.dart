class Question {
  final String questionText;
  final List<String> options;
  final String correctAnswer;

  Question(this.questionText, this.options, this.correctAnswer);
}

class Quiz {
  List<Question> getQuestions() {
    return [
      Question(
        "¿Cuál es una actividad física segura para las personas con diabetes tipo 1?",
        ["a) Ver televisión todo el día", "b) Hacer ejercicio regularmente, como caminar o nadar", "c) Nunca hacer ejercicio", "d) Solo jugar videojuegos"],
        "b) Hacer ejercicio regularmente, como caminar o nadar",
      ),
      Question(
        "¿Cuándo es necesario administrar insulina?",
        ["a) Solo los fines de semana", "b) Solo en la escuela", "c) Regularmente, según las indicaciones del médico", "d) Nunca es necesario"],
        "c) Regularmente, según las indicaciones del médico",
      ),
      Question(
        "¿Por qué es importante medir los niveles de glucosa en la sangre?",
        ["a) Para jugar", "b) Para controlar el azúcar en la sangre", "c) Para perder peso", "d) No es importante"],
        "b) Para controlar el azúcar en la sangre",
      ),
      Question(
        "¿Qué alimentos deben consumirse con moderación en una dieta para la diabetes tipo 1?",
        ["a) Frutas y verduras", "b) Dulces y alimentos ricos en azúcar", "c) Carnes magras y pescado", "d) Todos los alimentos son seguros"],
        "b) Dulces y alimentos ricos en azúcar",
      ),
      Question(
        "¿Qué se debe hacer si los niveles de azúcar en la sangre son demasiado altos?",
        ["a) Comer más dulces", "b) Beber más agua", "c) Administrar insulina según las indicaciones del médico", "d) Ignorar los niveles altos"],
        "c) Administrar insulina según las indicaciones del médico",
      ),
      Question(
        "¿Qué parte del cuerpo produce insulina?",
        ["a) Riñones", "b) Páncreas", "c) Corazón", "d) Estómago"],
        "b) Páncreas",
      ),
      Question(
        "¿Qué hace la insulina en el cuerpo?",
        ["a) Regula el azúcar en la sangre", "b) Produce energía", "c) Hace crecer el cabello", "d) Da color a la piel"],
        "a) Regula el azúcar en la sangre",
      ),
      Question(
        "¿Cómo se llama la herramienta que se usa para medir el nivel de azúcar en la sangre?",
        ["a) Termómetro", "b) Glucómetro", "c) Regla", "d) Binocular"],
        "b) Glucómetro",
      ),
      Question(
        "¿Cuándo es importante tomar insulina?",
        ["a) Solo en la noche", "b) Cuando los niveles de azúcar son altos", "c) Solo en días de fiesta", "d) Nunca es importante"],
        "b) Cuando los niveles de azúcar son altos",
      ),
      Question(
        "¿Por qué es importante llevar un registro de los niveles de azúcar?",
        ["a) Para jugar", "b) Para mostrar a los amigos", "c) Para compartir en redes sociales", "d) Para ayudar al médico a entender y manejar la diabetes"],
        "d) Para ayudar al médico a entender y manejar la diabetes",
      ),
      Question(
      "¿Cuál es un síntoma común de hipoglucemia en personas con diabetes?",
      ["a) Sed excesiva", "b) Niveles altos de azúcar en la sangre", "c) Mareos y sudoración", "d) Aumento de energía"],
      "c) Mareos y sudoración",
      ),
      Question(
        "¿Cuál es la importancia de llevar una identificación que indique la condición de diabetes?",
        ["a) Solo por precaución", "b) Para mostrar a los amigos", "c) En caso de emergencia médica", "d) No es importante"],
        "c) En caso de emergencia médica",
      ),
      Question(
        "¿Cuáles son algunos factores que pueden afectar los niveles de azúcar en la sangre?",
        ["a) La fase lunar", "b) El estrés y la enfermedad", "c) El color de la ropa", "d) Solo la dieta"],
        "b) El estrés y la enfermedad",
      ),
      Question(
        "¿Cuál es una recomendación para prevenir complicaciones a largo plazo de la diabetes?",
        ["a) No visitar al médico regularmente", "b) Ignorar los niveles de azúcar", "c) Mantener un control constante de los niveles de azúcar", "d) Consumir grandes cantidades de azúcar"],
        "c) Mantener un control constante de los niveles de azúcar",
      ),
      Question(
        "¿Qué tipo de ejercicio se recomienda para mejorar la sensibilidad a la insulina?",
        ["a) Ejercicio intenso y esporádico", "b) Ejercicio aeróbico regular", "c) Solo levantamiento de pesas", "d) Ningún tipo de ejercicio"],
        "b) Ejercicio aeróbico regular",
      ),
      Question(
        "¿Por qué es importante hacer ejercicio regularmente si tienes diabetes tipo 1?",
        ["a) Para tener músculos más fuertes.", "b) Para mantener controlado el azúcar en la sangre.", "c) Porque es divertido.", "d) Para poder comer más dulces."],
        "b) Para mantener controlado el azúcar en la sangre."
      ),
      Question(
        "¿Qué debe hacer una persona con diabetes tipo 1 si siente que sus niveles de azúcar están bajos?",
        ["a) Comer muchos dulces.", "b) Pedir ayuda a un adulto.", "c) Ignorar la sensación y seguir jugando.", "d) Tomar mucha agua."],
        "b) Pedir ayuda a un adulto."
      ),
      Question(
        "¿Qué órgano del cuerpo es importante cuidar cuando tienes diabetes tipo 1?",
        ["a) El hígado.", "b) Los pulmones.", "c) El corazón.", "d) El páncreas."],
        "d) El páncreas."
      ),
      Question(
        "¿Qué es importante llevar siempre contigo si tienes diabetes tipo 1 y sales de casa?",
        ["a) Juguetes.", "b) Un teléfono móvil.", "c) Una identificación que indique tu condición.", "d) Dulces para emergencias."],
        "c) Una identificación que indique tu condición."
      ),
      Question(
        "¿Qué se debe hacer antes de comer algo cuando se tiene diabetes tipo 1?",
        ["a) Decirle a tus amigos lo que vas a comer.", "b) Medir tu nivel de azúcar en la sangre.", "c) Comer sin preocuparte.", "d) No es necesario hacer nada."],
        "b) Medir tu nivel de azúcar en la sangre."
      ),
      Question(
        "¿Qué cuidado especial deben tener las personas con diabetes tipo 1 cuando hacen deporte?",
        ["a) No es necesario hacer deporte.", "b) Beber mucha agua.", "c) Usar equipo de protección.", "d) Medir el azúcar antes y después del ejercicio."],
        "d) Medir el azúcar antes y después del ejercicio."
      ),
      Question(
        "¿Por qué es importante ir al médico regularmente si tienes diabetes tipo 1?",
        ["a) Para tener más días libres.", "b) Para mantener bajo control tu salud y azúcar en la sangre.", "c) Para recibir dulces gratis.", "d) Porque es aburrido quedarse en casa."],
        "b) Para mantener bajo control tu salud y azúcar en la sangre."
      ),
      Question(
        "¿Qué puede ayudarte a sentirte mejor si te sientes triste por tener diabetes tipo 1?",
        ["a) Comer muchos dulces.", "b) Hablar con un adulto de confianza.", "c) Ignorar tus sentimientos.", "d) No hay forma de sentirse mejor."],
        "b) Hablar con un adulto de confianza."
      ),
      Question(
        "¿Qué debes hacer si accidentalmente te inyectas demasiada insulina?",
        ["a) No hacer nada, todo estará bien.", "b) Pedir ayuda a un adulto de inmediato.", "c) Comer muchos dulces para equilibrar.", "d) Tomar mucha agua."],
        "b) Pedir ayuda a un adulto de inmediato."
      ),
      Question(
        "¿Cuál es una forma divertida de mantener tus niveles de azúcar bajo control?",
        ["a) Comer muchos dulces.", "b) Hacer ejercicios en familia.", "c) Ver televisión todo el día.", "d) No prestar atención a lo que comes."],
        "b) Hacer ejercicios en familia."
      ),
    ];
  }
}

final List<Question> quizQuestions = Quiz().getQuestions();