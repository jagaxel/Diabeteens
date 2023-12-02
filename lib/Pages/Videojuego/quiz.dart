class Question {
  final String questionText;
  final List<String> options;
  final String correctAnswer;

  Question(this.questionText, this.options, this.correctAnswer);
}

final List<Question> quizQuestions = [
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
];
