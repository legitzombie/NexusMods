public class streak {
  let controller: ref<controller>;
  public let panel: ref<inkCompoundWidget>;
  private let imagesData: array<ImageData>;

  public let defaultResource: String;
  public let defaultPart: String;
  public let defaultColors: array<HDRColor>;

  public let defaultImageSize: array<Float>;
  public let defaultImagePosition: array<Float>;
  public let defaultImageRotation: Float;

  public let defaultTextSize: Int32;
  public let defaultTextColor: HDRColor;
  public let defaultTextPosition: array<Float>;

  public let templateText: array<String>;

  public func OnCreate(controller: ref<controller>) -> Void {
    this.controller = controller;
    this.defaultResource = "base\\gameplay\\gui\\common\\icons\\mappin_icons.inkatlas";
    this.defaultPart = "health";
    this.defaultColors = [
      colors.green(),
      colors.yellowGlow(),
      colors.redGlow(),
      colors.pinkGlow()
    ];

    this.defaultImageSize = [200.0, 40.0];
    this.defaultImagePosition = [-540.0, 325.0, 0.0, 0.0];
    this.defaultImageRotation = 270.0;

    this.defaultTextSize = 80;
    this.defaultTextColor = colors.pinkGlow();
    this.defaultTextPosition = [350.0, 75.0, 0.0, 0.0];

    this.templateText = [
      "STREAK",
      "img", "img", "img", "img"
    ];

    this.panel = this.controller.getSharedPanel(1, false);

  }

  public func Set(values: array<ImageData>) -> Void {
    this.imagesData = values;
  }

  public func Get() -> array<ImageData> {
    return this.imagesData;
  }

  public func Display(
    resource: array<String>,
    part: array<String>,
    color: array<HDRColor>
  ) -> Void {
    this.panel.RemoveAllChildren();
    let pos = this.defaultImagePosition;

    this.displayTitle();

    let i: Int32 = 0;
    while i < ArraySize(resource) {

        let currentImage = new Image();
        let imageData: ImageData;
        imageData.resource = resource[i];
        imageData.part = part[i];
        imageData.color = color[i];

        ////modlog(n"DEBUG", s"src2: \(imageData.resource)");
        ////modlog(n"DEBUG", s"part2: \(imageData.part)");
        ////modlog(n"DEBUG", s"color2: \(imageData.color)");


        if i != 0 {
            pos[0] = 0.0;
        }


        imageData.object = currentImage.Display(
          this.panel,
          imageData.resource,
          imageData.part,
          this.defaultImageSize,
          imageData.color,
          pos,
          this.defaultImageRotation,
          true,
          false,
          false
        );

      i += 1;
    };

  }

  private func displayTitle() -> Void {
   

          displayLabel(
          this.panel,
          this.templateText[0],
          this.defaultTextSize,
          this.defaultTextColor,
          this.defaultTextPosition,
          true,
          false,
          true
        );
  };

  public func Reset() -> Void {

            this.displayTitle();

    let i: Int32 = 0;
    while i < 4 {

        let pos = this.defaultImagePosition;

        if i != 0 {
            pos[0] = 0.0;
        }

        let data: ImageData;
        data.resource = this.defaultResource;
        data.part = this.defaultPart;
        data.color = this.defaultTextColor;

        if ArraySize(this.imagesData) > i {
            this.imagesData[i] = data;
        }else {
            ArrayPush(this.imagesData, data);
        };


      i += 1;
    };
  }
}
