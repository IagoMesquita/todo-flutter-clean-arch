class ToDoModel {
  final String id;
  final String title;
  final bool isDone;

  const ToDoModel({
    required this.id,
    required this.title,
    required this.isDone,
  });

  // Traduzir o que vem do Firebase em algo que sua aplicação entende (Esse faz sentido)
  factory ToDoModel.fromMap(Map<String, dynamic> map, String id) {
    // -> fromJson
    return ToDoModel(
      id: id,
      title: map['title'] ?? '',
      isDone: map['isDone'] ?? false,
    );
  }

  // Preparar seus dados para serem salvos no Firebase. Gera o Map<String, dynamic> esperado pelo Firestore. (Esse faz seentido)
  Map<String, dynamic> toMap() {
    // -> toJson
    return {'title': title, 'isDone': isDone};
  }
}

// Este model é responsável por converter entre Firebase/JSON e a entidade ToDo.

//🔁 Esse model será usado para conversar com o Firebase (ou outra fonte de dados).
// fromMap() lê os dados vindos do banco, toMap() prepara os dados para envio.

// ToDoModel é um Data Model, fica na camada data/, e faz conversão para/da entidade
// Nota: Equivalente a um DTO + Mapper, usado na camada data/ para ler e gravar dados no Firebase, BD...

// 🔁 2. E o fromMap/toMap? Seriam como fromEntity/toEntity?
// Exatamente!

// fromMap() → como fromDto() ou fromJson()

// toMap() → como toDto() ou toJson()

// Você poderia sim separar isso em Mappers puros se quisesse seguir mais fielmente o estilo Java.
//Mas como em Dart/Flutter é comum usar factory constructors e métodos direto na classe Model, fica mais compacto.

// Método	       Função
// fromMap()	   Firebase → Model
// toMap()	     Model → Firebase
// fromEntity()	 Entidade → Model (útil para salvar)
// toEntity()	   Model → Entidade (útil para retornar ao domínio)
