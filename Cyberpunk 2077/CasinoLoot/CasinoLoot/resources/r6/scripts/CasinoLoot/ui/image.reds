public struct ImageData {
  public let object: ref<inkImage>;
  public let resource: String;
  public let part: String;
  public let color: HDRColor;
}


public class Image {

public func Display(
  panel: ref<inkCompoundWidget>, 
  resource: String, 
  part: String,
  size: array<Float>, 
  color: HDRColor, 
  margin: array<Float>, 
  rotation: Float,
  va: Bool, 
  ha: Bool, 
  fitContent: Bool
) -> ref<inkImage> {

 let imageWidget: ref<inkImage> = new inkImage();
imageWidget.SetName(StringToName("image_" + RandRange(0, 999999)));
imageWidget.SetSize(new Vector2(size[0], size[1]));
imageWidget.SetAtlasResource(ResRef.FromString(resource));
imageWidget.SetTexturePart(StringToName(part));
imageWidget.SetMargin(new inkMargin(margin[0], margin[1], margin[2], margin[3]));

  if va {
    imageWidget.SetVAlign(inkEVerticalAlign.Top);
  };
  if ha {
    imageWidget.SetHAlign(inkEHorizontalAlign.Left);
  }else {
    imageWidget.SetHAlign(inkEHorizontalAlign.Center);
  };

imageWidget.SetRotation(rotation);
imageWidget.SetTintColor(color);
imageWidget.SetFitToContent(fitContent);
imageWidget.Reparent(panel);

return imageWidget;

}


}
