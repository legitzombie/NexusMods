public class jackpot {

    let controller: ref<controller>;
   private let panel: ref<inkCompoundWidget>;

public func OnCreate(controller: ref<controller>) -> Void {
    this.controller = controller;
    let panelBuilder = new panelBuilder();
    panelBuilder.OnCreate();
    this.panel = panelBuilder.horizontalPanel(controller, [900.0, 1000.0], [0.0, 0.0, 0.0, 0.0], [0.0, 0.0], 0, false, false);
    this.Display(0, colors.yellowGlow());
}

public func Display(colorOverrideIndex: Int32, overrideColor: HDRColor) -> Void {
    ////modlog(n"DEBUG", s"Display Jackpot");
    this.panel.RemoveAllChildren();

    let templateText = this.GetTemplateText();
    let templateImageColor = this.GetTemplateImageColors();
    let templateRowsEndIndex = this.GetTemplateRowsEndIndex();
    let templatePositionLeft = this.GetTemplatePositionLeft();
    let white = colors.white();
    let yellowGlow = colors.yellowGlow();
    let purple = colors.purple();

    let jackpotLabelPosition = [300.0, 75.0, 0.0, 0.0];
    let freespinLabelPosition = [-550.0, 735.0, 0.0, 0.0];
    let originRowPositionBase = [-320.0, 150.0, 0.0, 0.0];  // make a copy
    let spacingRowTop = 75.0;

    let fontsize = 48;
    let position = jackpotLabelPosition;
    let imgIndex = 0;
    let row = 0;
    let i = 0;
    let prize = 0;

    // copy to mutate safely inside loop
    let originRowPosition = [originRowPositionBase[0], originRowPositionBase[1], originRowPositionBase[2], originRowPositionBase[3]];

    while i < ArraySize(templateText) {
        if i >= templateRowsEndIndex[row] {
            position[0] = templatePositionLeft[row];
            row += 1;
            position[1] = originRowPosition[1] + (Cast<Float>(row) * spacingRowTop);
            if  row == 7 {
                originRowPosition[1] += spacingRowTop;
                position[1] = freespinLabelPosition[1];
            };
        } else if i > 0 {
            position[0] = 0.0;
        };

        let color = white;
        let text = templateText[i];

        if StrContains(text, "+") || StrContains(text, "-") || StrContains(text, "|") {
            fontsize = 48;
            color = purple;
        } else if StrContains(text, "JACKPOT") || StrContains(text, "FREE SPINS") {
            fontsize = 80;
            color = yellowGlow;
            if StrContains(text, "FREE SPINS") {
                color = colors.green();
                originRowPosition[1] += spacingRowTop;
            };
        } else if StrContains(text, "x") {
            fontsize = 60;
            color = colors.getGradient(prize);
            prize += 1;
        } else {
            fontsize = 48;
        };

        if StrContains(text, "img") {
            let currentImage = new Image();
            currentImage.Display(this.panel, "base\\gameplay\\gui\\common\\icons\\mappin_icons.inkatlas", "lootIconic", [75.0, 75.0], templateImageColor[imgIndex], position, 270.0, true, true, false);
            imgIndex += 1;
        } else {
            ////modlog(n"DEBUG", s"Text / Index: \(text)/\(i)");
            if colorOverrideIndex > 0 && colorOverrideIndex == i {
               ////modlog(n"DEBUG", s"Changed color of: \(text)");
                ////modlog(n"DEBUG", s"prize: \(prize)");
                if prize < 6 {
                    color = colors.getGradient(prize);
                }else {
                    color = colors.green();
                };
            }
            displayLabel(this.panel, text, fontsize, color, position, true, true, true);
        };

        i += 1;
    };
}

    private func GetTemplateText() -> array<String> {
        return [
            "JACKPOT", // 1
            "img", "+", "img", "+", "img", "+", "img", " - ", "4 of a kind", " - ", "50x", // 11
            "img", "+", "img", "+", "img", " - ", "3 of a kind", " - ", "25x", // 9
            "img", "+", "img", " - ", "2 of a kind", " - ", "10x", // 7
            "img", "+", "img", "+", "img", "+", "img", " - ", "4 of a type", " - ", "5x", // 11
            "img", "+", "img", "+", "img", " - ", "3 of a type", " - ", "4x", // 9
            "img", "+", "img", " - ", "2 of a type", " - ", "3x", // 7
            "FREE SPINS", // 1
            "img", "+", "img", "+", "img", "+", "img", " - ", "2 of 2 kinds", // 9
            "img", "+", "img", "+", "img", "+", "img", " - ", "4 kinds", // 9
            "img", "+", "img", "+", "img", " - ", "3 kinds" // 7
        ];
    }

    private func GetTemplateImageColors() -> array<HDRColor> {
        return [
            colors.red(), colors.red(), colors.red(), colors.red(),
            colors.red(), colors.red(), colors.red(),
            colors.red(), colors.red(),
            colors.purple(), colors.purple(), colors.purple(), colors.purple(),
            colors.purple(), colors.purple(), colors.purple(),
            colors.purple(), colors.purple(),
            colors.blue(), colors.yellow(), colors.blue(), colors.yellow(),
            colors.blue(), colors.yellow(), colors.red(), colors.purple(),
            colors.blue(), colors.yellow(), colors.red()
        ];
    }

    private func GetTemplateRowsEndIndex() -> array<Int32> {
        return [1, 12, 21, 28, 39, 48, 55, 56, 65, 74, 81];
    }

    private func GetTemplatePositionLeft() -> array<Float> {
        return [-525.0, -652.0, -547.0, -738.0, -625.0, -523.0, -550.0, -480.0, -640.0, -459.0];
    }
}
