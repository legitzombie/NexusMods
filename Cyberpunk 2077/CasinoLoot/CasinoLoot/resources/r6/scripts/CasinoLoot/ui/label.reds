public func displayLabel(
  panel: ref<inkCompoundWidget>, 
  title: String, 
  size: Int32, 
  color: HDRColor, 
  margin: array<Float>, 
  va: Bool, 
  ha: Bool, 
  fitContent: Bool
) -> Void {
  let textWidget: ref<inkText> = new inkText();
  textWidget.SetName(StringToName("label_" + RandRange(0, 999999))); // give unique ID
  textWidget.SetText(title);
  textWidget.SetFontSize(size);
  textWidget.SetMargin(new inkMargin(margin[0], margin[1], margin[2], margin[3]));
  if va {
  textWidget.SetVAlign(inkEVerticalAlign.Top);
  };
  if ha {
    textWidget.SetHAlign(inkEHorizontalAlign.Center);
  };
  textWidget.SetFitToContent(fitContent);
  textWidget.SetFontFamily("base\\gameplay\\gui\\fonts\\raj\\raj.inkfontfamily");
  textWidget.SetFontStyle(n"Bold");
  textWidget.SetTintColor(color);
  textWidget.Reparent(panel);
}


public func displayLabels(
  panel: ref<inkCompoundWidget>, 
  titles: array<String>, 
  size: Int32, 
  colors: array<HDRColor>, 
  margins: array<Float>,
  spacingLeft: Float
) -> Void {


  let i = 0;
  while i < ArraySize(titles) {
        // content
        let margin = margins;
        margin[0] += spacingLeft * Cast<Float>(i);
        displayLabel(panel, titles[i], size, colors[i], margin, true, false, true); 
    i += 1;
  };


  };