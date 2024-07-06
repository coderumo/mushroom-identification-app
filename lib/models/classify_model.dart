class ClassifyModel {
  final bool canEat;
  final String chatgptData;
  final int predictedClass;
  final double predictedProb;
  final String trueLabels;

  ClassifyModel({
    required this.canEat,
    required this.chatgptData,
    required this.predictedClass,
    required this.predictedProb,
    required this.trueLabels,
  });

  factory ClassifyModel.fromJson(Map<String, dynamic> json) {
    return ClassifyModel(
      canEat: json['canEat'] ?? false,
      chatgptData: json['chatgpt_data'] ?? '',
      predictedClass: json['predicted_class'] ?? 0,
      predictedProb: (json['predicted_prob'] ?? 0.0).toDouble(),
      trueLabels: json['true_labels'] ?? '',
    );
  }

  Map<String, dynamic> toJson() => {
        'canEat': canEat,
        'chatgpt_data': chatgptData,
        'predicted_class': predictedClass,
        'predicted_prob': predictedProb,
        'true_labels': trueLabels,
      };
}

void main() {
  final jsonData = {
    "canEat": false,
    "chatgpt_data":
        "Tabii ki! Amanita muscaria, diğer adıyla Yenilemez mantar ya da Kızıl başlı kuzgunmantarı, genellikle kırmızı renkte, beyaz benekli bir sapka ve beyaz bir gövdeye sahip olan zehirli bir mantar türüdür. Bu mantarın zehirli olduğu bilinmektedir ve tüketilmemesi önerilmektedir.\n\nAmanita muscaria, psikoaktif bir madde olan muscimol içerir. Ancak bu madde, insanlar tarafından tüketildiğinde çeşitli yan etkilere yol açabilir ve ciddi sağlık sorunlarına neden olabilir. Bu nedenle kesinlikle yenilmemesi ve tüketilmemesi gereken bir mantar türüdür.\n\nAyrıca Amanita muscaria'nın kültürel ve tıbbi amaçlar için kullanıldığı bazı topluluklar bulunmaktadır, ancak yine de bu mantarın zehirli olduğu unutulmamalı ve uzmanlar tarafından yönlendirilmeden tüketilmemelidir. Mantar toplamaya veya tüketmeye karar verirken güvenilir kaynaklardan doğru bilgi edinmek önemlidir.",
    "predicted_class": 0,
    "predicted_prob": 0.9855570197105408,
    "true_labels": "Amanita muscaria"
  };

  final classifyModel = ClassifyModel.fromJson(jsonData);
  print(classifyModel.toJson());
}
