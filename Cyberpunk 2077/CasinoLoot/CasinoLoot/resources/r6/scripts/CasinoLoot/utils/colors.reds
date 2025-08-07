public class colors {


    public static func red() -> HDRColor {
        return new HDRColor(0.86, 0.0, 0.0, 1.0);
    }

    public static func black() -> HDRColor {
        return new HDRColor(0.0, 0.0, 0.0, 1.0);
    }

    public static func blue() -> HDRColor {
        return new HDRColor(0.145, 0.0, 1.0, 1.0);
    }

    public static func yellow() -> HDRColor {
        return new HDRColor(1.0, 1.07, 0.000, 1.0);
    }

    public static func purple() -> HDRColor {
        return new HDRColor(0.573, 0.007, 1.0, 1.0);
    }

    public static func mint() -> HDRColor {
        return new HDRColor(0.0, 1.0, 1.0, 1.0);
    }

    public static func cyan() -> HDRColor {
        return new HDRColor(0.818, 1.0, 1.0, 1.0);
    }

    public static func white() -> HDRColor {
        return new HDRColor(1.0, 1.0, 1.0, 1.0);
    }

    public static func gray() -> HDRColor {
        return new HDRColor(0.90, 0.90, 0.90, 1.0);
    }

    public static func green() -> HDRColor {
        return new HDRColor(0.818, 2.0, 2.0, 1.0);
    }

    public static func greenGlow() -> HDRColor {
        return new HDRColor(0.0, 2.0, 0.0, 1.0);
    }

    public static func orangeGlow() -> HDRColor {
        return new HDRColor(2.0, 0.6, 0.0, 1.0);
    }

    public static func redGlow() -> HDRColor {
        return new HDRColor(1.5, 0.0, 0.0, 1.0);
    }

    public static func yellowGlow() -> HDRColor {
        return new HDRColor(1.0, 2.0, 0.000, 1.0);
    }

    public static func purpleGlow() -> HDRColor {
        return new HDRColor(0.429, 0.00, 2.0, 1.0);
    }

    public static func pinkGlow() -> HDRColor {
        return new HDRColor(1.726, 0.00, 2.0, 1.0);
    }

    public static func cyanGlow() -> HDRColor {
        return new HDRColor(0.0, 2.0, 2.0, 1.0);
    }

    public static func blueGlow() -> HDRColor {
        return new HDRColor(0.0, 0.6, 2.0, 1.0);
    }



    public static func whiteGlow() -> HDRColor {
        return new HDRColor(2.0, 2.0, 2.0, 1.0);
    }

    public static func getGradient(i: Int32) -> HDRColor {
        let gradient: array<HDRColor> = [];
        ArrayPush(gradient, colors.redGlow());
        ArrayPush(gradient, colors.orangeGlow());
        ArrayPush(gradient, colors.pinkGlow());
        ArrayPush(gradient, colors.yellowGlow());
        ArrayPush(gradient, colors.greenGlow());
        ArrayPush(gradient, colors.cyanGlow());


        if i < 0 || i >= ArraySize(gradient) {
            return colors.whiteGlow(); // fallback
        }

        return gradient[i];
    }



    public static func Set(colors: array<HDRColor>, patterns: array<Int32>, length: Int32) -> array<HDRColor> {

        let Colors: array<HDRColor>;
        let i = 0;

        if length == 0 {
            //////modlog(n"DEBUG", s"DefaultColor: \(patterns[0])");
            ArrayPush(Colors, colors[patterns[0]]);
        }

        while i <= length {  
            //////modlog(n"DEBUG", s"Color: \(patterns[i])");
            ArrayPush(Colors, colors[patterns[i]]);
            i += 1;
        };

        return Colors;
    }


}
