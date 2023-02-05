import { ModCallback } from "isaac-typescript-definitions";
import { CollectibleType, PlayerType } from "isaac-typescript-definitions/dist/src/enums/collections/subTypes";
import { isTainted } from "isaacscript-common/dist/src/functions/players";

const MOD_NAME = "taintedrevives";

main();

function main() {
  // Instantiate a new mod object, which grants the ability to add callback functions that
  // correspond to in-game events.
  const mod = RegisterMod(MOD_NAME, 1);

  // Register a callback function that corresponds to when a new run is started.
  mod.AddCallback(ModCallback.POST_GAME_STARTED, taintedRevives);

  // Print a message to the "log.txt" file.
  Isaac.DebugString(`${MOD_NAME} initialized.`);
}

function taintedRevives(){
  const player = Isaac.GetPlayer();
  if(isTainted(player)){
    Isaac.DebugString("You are playing as Tainted character!");
    if(player.HasCollectible(CollectibleType.LAZARUS_RAGS)){
      Isaac.DebugString("Player has Lazarus Rags");
      // Isaac.SetPlayer(PlayerType.LAZARUS_B);
    }
  }
}
