public class money {
    let player: ref<GameObject>;
    let moneyID: ItemID;
    let controller: ref<controller>;

    public func OnCreate(
        player: ref<GameObject>,
        controller: ref<controller>
    ) -> Void {
        this.player = player;

        let moneyKey = t"Items.money";
        this.moneyID = ItemID.CreateQuery(moneyKey);
    }


    public func isBrokeboi() -> Bool {
        if this.Get() < 5000 {
            // If you're a broke boi just say so! *PokiKiss*
            this.controller.getSharedButton(0).resetText();
            this.controller.sound().Play("q305_bunker_ui_denied_nonspatial");
            return true;
        }
        return false;
    }

    public func Get() -> Int32 {
        return GameInstance.GetTransactionSystem(this.player.GetGame()).GetItemQuantity(this.player, this.moneyID);
    }
    public func Give(amount: Int32) -> Void {
        GameInstance.GetTransactionSystem(this.player.GetGame()).GiveItem(this.player, this.moneyID, amount);
    }

    public func Remove(amount: Int32) -> Void {
        GameInstance.GetTransactionSystem(this.player.GetGame()).RemoveItem(this.player, this.moneyID, amount);
    }
}