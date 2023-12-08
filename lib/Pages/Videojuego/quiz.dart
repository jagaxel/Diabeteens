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
    ];
  }
}

final List<Question> quizQuestions = Quiz().getQuestions();