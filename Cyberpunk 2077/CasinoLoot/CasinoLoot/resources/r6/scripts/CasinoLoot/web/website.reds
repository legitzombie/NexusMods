import Codeware.UI.*
import Audioware.*



@if(!ModuleExists("Gacha.Loot"))
@addField(BrowserController)
private let showSite: Bool;

@if(!ModuleExists("Gacha.Loot"))
@addMethod(BrowserController)
protected cb func OnShowEvent(evt: ref<ShowEvent>) -> Bool {
  this.showSite = evt.show;
}


@if(!ModuleExists("Gacha.Loot"))
@wrapMethod(ComputerInkGameController)
private final func ShowMenuByName(elementName: String) -> Void {
  if Equals(elementName, "gachaLoot") {
    this.QueueEvent(ShowEvent.Create(true));
    let internetData: SInternetData = this.GetOwner().GetDevicePS().GetInternetData();
    this.GetMainLayoutController().ShowInternet(internetData.startingPage);
    this.RequestMainMenuButtonWidgetsUpdate();
    if NotEquals(elementName, "mainMenu") {
      this.GetMainLayoutController().MarkManuButtonAsSelected(elementName);
    };
    return;
  };

  this.QueueEvent(ShowEvent.Create(false));
  wrappedMethod(elementName);
}

@if(!ModuleExists("Gacha.Loot"))
@wrapMethod(ComputerInkGameController)
private final func HideMenuByName(elementName: String) -> Void {
  if Equals(elementName, "gachaLoot") {
    this.GetMainLayoutController().HideInternet();
    return;
  };

  wrappedMethod(elementName);
}

@if(!ModuleExists("Gacha.Loot"))
@wrapMethod(ComputerControllerPS)
public final func GetMenuButtonWidgets() -> array<SComputerMenuButtonWidgetPackage> {
  let packages: array<SComputerMenuButtonWidgetPackage> = wrappedMethod();
  let package: SComputerMenuButtonWidgetPackage;

  if this.IsMenuEnabled(EComputerMenuType.INTERNET) && ArraySize(packages) > 0 {
    package.widgetName = "gachaLoot";
    package.displayName = "Casino";
    package.ownerID = this.GetID();
    package.iconID = n"iconInternet"; 
    package.widgetTweakDBID = this.GetMenuButtonWidgetTweakDBID();
    package.isValid = true;
    SWidgetPackageBase.ResolveWidgetTweakDBData(package.widgetTweakDBID, package.libraryID, package.libraryPath);
    ArrayPush(packages, package);
  };

  return packages;
}

@if(!ModuleExists("Gacha.Loot"))
@wrapMethod(ComputerMenuButtonController)
public func Initialize(gameController: ref<ComputerInkGameController>, widgetData: SComputerMenuButtonWidgetPackage) -> Void {
  wrappedMethod(gameController, widgetData);

  this.setIcon(widgetData);
}

@addMethod(ComputerMenuButtonController)
private func setIcon(widgetData: SComputerMenuButtonWidgetPackage) -> Void {
  if Equals(widgetData.widgetName, "gachaLoot") {
    inkImageRef.SetTexturePart(this.m_iconWidget, n"cash_symbol_large"); 
    inkImageRef.SetAtlasResource(this.m_iconWidget, r"base\\gameplay\\gui\\common\\icons\\atlas_cash.inkatlas");
  };
}



@if(!ModuleExists("Gacha.Loot"))
@wrapMethod(BrowserController)
protected cb func OnPageSpawned(widget: ref<inkWidget>, userData: ref<IScriptable>) -> Bool {
  wrappedMethod(widget, userData);

  let controller = this.m_currentPage.GetController();
  let currentController = controller as WebPage;

  if this.showSite {

    let root: ref<inkCompoundWidget> = this.GetRootCompoundWidget();
          let prevCanvas: ref<inkWidget> = root.GetWidget(n"RootCanv");
      if IsDefined(prevCanvas) {
        root.RemoveChild(prevCanvas);
      }

      if IsDefined(currentController) {
        inkTextRef.SetText(this.m_addressText, "NETdir://casino.loot");
        currentController.PopulateView(this.m_gameController.GetPlayerControlledObject(), this);
      }
  }
}

@addField(WebPage)
private let controller: ref<controller>;

@addMethod(WebPage)
public func PopulateView(player: ref<GameObject>, page: ref<BrowserController>) -> Void {

  this.controller = new controller();
  this.controller.onCreate(this.GetRootCompoundWidget(), player, page);

}

public class ShowEvent extends Event {
  let show: Bool;

  public static func Create(show: Bool) -> ref<ShowEvent> {
    let self: ref<ShowEvent> = new ShowEvent();
    self.show = show;
    return self;
  }
}
