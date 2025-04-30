class ShippingFeeModel {
  String zone;
  EssentialPlan essentialPlan;

  ShippingFeeModel({
    required this.zone,
    required this.essentialPlan,
  });

  factory ShippingFeeModel.fromJson(Map<String, dynamic> json) =>
      ShippingFeeModel(
        zone: json["zone"],
        essentialPlan: EssentialPlan.fromJson(json["essentialPlan"]),
      );

  Map<String, dynamic> toJson() => {
        "zone": zone,
        "essentialPlan": essentialPlan.toJson(),
      };
}

class EssentialPlan {
  Eshopbox eshopboxStandard;
  Eshopbox eshopboxExpress;
  Eshopbox eshopboxPriority;

  EssentialPlan({
    required this.eshopboxStandard,
    required this.eshopboxExpress,
    required this.eshopboxPriority,
  });

  factory EssentialPlan.fromJson(Map<String, dynamic> json) => EssentialPlan(
        eshopboxStandard: Eshopbox.fromJson(json["eshopboxStandard"]),
        eshopboxExpress: Eshopbox.fromJson(json["eshopboxExpress"]),
        eshopboxPriority: Eshopbox.fromJson(json["eshopboxPrime"]),
      );

  Map<String, dynamic> toJson() => {
        "eshopboxStandard": eshopboxStandard.toJson(),
        "eshopboxExpress": eshopboxExpress.toJson(),
        "eshopboxPrime": eshopboxPriority.toJson(),
      };
}

class Eshopbox {
  num shippingBaseFreight;
  num expressSurcharge;
  num codCollectionFees;
  num reverseShippingFees;
  num fuelSurcharge;
  num doorstepQcFees;
  num gst;
  num totalShippingCharges;
  num estimatedDeliveryDays;

  Eshopbox({
    required this.shippingBaseFreight,
    required this.expressSurcharge,
    required this.codCollectionFees,
    required this.reverseShippingFees,
    required this.fuelSurcharge,
    required this.doorstepQcFees,
    required this.gst,
    required this.totalShippingCharges,
    required this.estimatedDeliveryDays,
  });

  factory Eshopbox.fromJson(Map<String, dynamic> json) => Eshopbox(
        shippingBaseFreight: json["shippingBaseFreight"],
        expressSurcharge: json["expressSurcharge"],
        codCollectionFees: json["COD collection fees"],
        reverseShippingFees: json["reverseShippingFees"],
        fuelSurcharge: json["fuelSurcharge"],
        doorstepQcFees: json["Doorstep QC fees"],
        gst: json["gst"]?.toDouble(),
        totalShippingCharges: json["totalShippingCharges"]?.toDouble(),
        estimatedDeliveryDays: json["estimatedDeliveryDays"],
      );

  Map<String, dynamic> toJson() => {
        "shippingBaseFreight": shippingBaseFreight,
        "expressSurcharge": expressSurcharge,
        "COD collection fees": codCollectionFees,
        "reverseShippingFees": reverseShippingFees,
        "fuelSurcharge": fuelSurcharge,
        "Doorstep QC fees": doorstepQcFees,
        "gst": gst,
        "totalShippingCharges": totalShippingCharges,
        "estimatedDeliveryDays": estimatedDeliveryDays,
      };
}
