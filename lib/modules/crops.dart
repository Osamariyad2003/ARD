import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Crops extends StatelessWidget {
  TextStyle cropTitleStyle = TextStyle(
    decoration: TextDecoration.none, //to remove the underline under the text
    fontSize: 24, // Font size for the text
    color: Colors.grey,
  );

  TextStyle factorTitleStyle = TextStyle(
    decoration: TextDecoration.none, //to remove the underline under the text
    fontSize: 20, // Font size for the text
    color: Colors.grey,
  );

  BoxDecoration kDecorationimg = BoxDecoration(
    image: DecorationImage(
      colorFilter: ColorFilter.mode(
        Colors.white.withOpacity(0.2), // Reduce opacity for watermark effect
        BlendMode
            .dstATop, // Blending mode to overlay the image like a watermark
      ),
      image: AssetImage('assets/ard.png'), // Update with your image path
      fit: BoxFit.cover, // Cover the entire container with the image
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: kDecorationimg,
      child: ListView(
        padding: EdgeInsets.all(10), // Padding for the ListView
        children: [
          Column(
            children: [
              Row(
                children: [
                  bigCircle,
                  Text(
                    "  Corn : ",
                    style: cropTitleStyle,
                  ),
                ],
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  factorTaps(
                    factorTitleStyle: factorTitleStyle,
                    factorTitle: "Soil-Moisture",
                  ),
                  factorTaps(
                    factorTitleStyle: factorTitleStyle,
                    factorTitle: "Pest",
                  ),
                  factorTaps(
                    factorTitleStyle: factorTitleStyle,
                    factorTitle: "Frost",
                  ),
                ],
              ),

              SizedBox(
                height: 10,
              ),
              RecommendationArticles(
                heading: 'Implement Effective Drainage Solutions',
                body:
                'Effective drainage is crucial in high soil moisture environments to prevent waterlogging, which can lead to root rot, reduced aeration, and overall poor plant health. By installing tile drainage systems or ensuring proper surface drainage, you can significantly improve soil aeration and reduce excess moisture around the root zone, allowing corn plants to thrive even in wet conditions.',
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  bigCircle,
                  Text(
                    "  Wheat : ",
                    style: cropTitleStyle,
                  ),
                ],
              ),
              RecommendationArticles(
                  heading: 'Improve Soil Drainage',
                  body:'Similar to corn, wheat is also susceptible to waterlogging, which can hinder root development and lead to diseases such as root rot and Fusarium head blight. Improving soil drainage—through the installation of tile drains, enhancing surface drainage, or utilizing raised beds—will help to quickly remove excess water from the soil. This ensures that the wheat roots have adequate oxygen and reduces the risk of disease, leading to healthier plants and better yields.'),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  bigCircle,
                  Text(
                    "  Potato : ",
                    style: cropTitleStyle,
                  ),
                ],
              ),
              RecommendationArticles(
                  heading: 'Improve Soil Drainage and Aeration',
                  body:'Potatoes are particularly vulnerable to diseases like late blight and tuber rot caused by excessive moisture. Improving soil drainage through raised beds or incorporating organic matter can enhance aeration and moisture retention in the root zone. Additionally, monitoring irrigation practices is crucial to prevent over-saturation.'),

            ],
          ),
        ],
      ),
    );
  }
}

class RecommendationArticles extends StatelessWidget {
  RecommendationArticles({required this.heading, required this.body});
  final String heading;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '$heading',
              style:
              TextStyle(fontWeight: FontWeight.bold, color: Colors.black54),
            ),
            TextSpan(
              text: '$body',
              style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w300),
            ),
          ],
        ),
      ),
    );
  }
}

class factorTaps extends StatelessWidget {
  const factorTaps(
      {super.key, required this.factorTitleStyle, required this.factorTitle});
  final String factorTitle;
  final TextStyle factorTitleStyle;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.transparent,
          border: Border.symmetric(
            vertical: BorderSide(
              color: Colors.grey, // Set the vertical border color to black
              width: 3.0, // Set the vertical border width (thickness)
            ),
            horizontal: BorderSide(
              color: Colors.grey, // Set the horizontal border color to black
              width: 3.0, // Set the horizontal border width (thickness)
            ),
          ),
        ),
        height: 45,
        width: 150,
        child: TextButton(
          onPressed: () {},
          child: Text(
            "$factorTitle",
            style: factorTitleStyle,
          ), // Add text or any widget inside the TextButton
        ),
      ),
    );
  }
}

Widget bigCircle = new Container(
  width: 50.0, // Width of the circle
  height: 50.0, // Height of the circle
  decoration: new BoxDecoration(
    color: Colors.transparent, // No fill color, transparent background
    shape: BoxShape.circle, // Circular shape
    border: Border.all(
      // Add border around the circle
      color: Colors.grey, // Border color (customize as needed)
      width: 3.0, // Border width (customize as needed)
    ),
  ),
);
