//Upon being applied:
//Last for 3 days adding 2 points of tone every 6 hours.
//Can be removed early in the masturbation menu.


package classes.Items.Miscellaneous
{
	import classes.ItemSlotClass;
	import classes.GLOBAL;
	import classes.Creature;
	import classes.kGAMECLASS;	
	import classes.Characters.PlayerCharacter;
	import classes.GameData.TooltipManager;
	import classes.StringUtil;
	import classes.Engine.Interfaces.*;
	
	public class PumpUp extends ItemSlotClass {
		
		//constructor
		public function PumpUp() {
			this._latestVersion = 1;
			
			this.quantity = 1;
			this.stackSize = 50;
			this.type = GLOBAL.PILL;
			
			//Used on inventory buttons
			this.shortName = "PumpUp!";
			
			//Regular name
			this.longName = "PUMP UP!";
			
			TooltipManager.addFullName(this.shortName, StringUtil.toTitleCase(this.longName));
			
			//Longass shit, not sure what used for yet.
			this.description = "a cream filled jar labelled PUMP UP!";

			//Displayed on tooltips during mouseovers
			this.tooltip = "A simple jar with a comically toned, almost cartoonish arm on the label with the words ‘PUMP UP!’ written right below. Inside there is a cream made with specialized microsurgeons and hormones designed to overwork the body and make small genetic modifications. When applied it should enhance the growth of the user’s musculature for the duration of three days.";
			
			TooltipManager.addTooltip(this.shortName, this.tooltip);
			
			this.attackVerb = "";
			
			//Information
			this.basePrice = 2000;
			this.attack = 0;
			this.defense = 0;
			this.shieldDefense = 0;
			this.shields = 0;
			this.sexiness = 0;
			this.critBonus = 0;
			this.evasion = 0;
			this.fortification = 0;
			
			this.version = _latestVersion;
		}
		
		//METHOD ACTING!
		override public function useFunction(target:Creature, usingCreature:Creature = null):Boolean {
			kGAMECLASS.clearOutput();
			
			if(target is PlayerCharacter) {
				author("Lashcharge");
				
				//already using pump up
				if(target.hasStatusEffect("Pump Up Cream")) {
					output("Your [pc.chest]");
					if (target.hasBreasts()) output(" are");
					else output(" is");
					output(" still covered by a thin membrane of PUMP UP! cream doing its nanite-magic. You will have to remove it before you apply another dose.");
					
					//raise item count, as none should have been consumed
					if(!kGAMECLASS.infiniteItems()) quantity++;
					return false;
					
				//not yet using pump up
				} else {
					//tone 75+
					if(target.tone >= 75) {
						if (target.hasArmor() || target.hasUpperGarment()) {
							output("You take off");
							if (target.hasArmor()) output(" your [pc.armor]");
							if (target.hasArmor() && target.hasUpperGarment()) output(" and");
							if (!target.hasArmor()) output(" your");
							if (target.hasUpperGarment()) output(" [pc.upperGarment]");
							output(" that strain to hold your incredible musculature");
							if (target.hasLowerGarment()) output(", leaving only the [pc.lowerUndergarment]");
							output(" and let the whole world admire your herculean frame.");
						}
						output(" Easily opening the jar, you grab a large dollop of cream and slide it over your arms, massaging the biceps to make sure they receive a good coating. More cream and more massaging covers your [pc.fullChest], impressive six-pack and muscular back. Crouching down, you slather your quads, thighs, glutes, calves and feet, and use the last of the cream to cover your neck and jaw. It quickly dries, leaving you covered in a thin membrane that makes you look like you are permanently oiled.");

					//tone less than 75 and thickness 75+
					} else if (target.tone < 75 && target.thickness >= 75) {
						if (target.hasArmor() || target.hasUpperGarment()) { 
							output("You undress");
							if (target.hasUpperGarment()) output(" down to your [pc.lowerUndergarment]");
							output(" and expose your generous mass for the whole world to see.");
						}
						output(" It takes a lot of effort to open the stuck lid, your plump body jiggling with every attempt, before it finally snaps open. You dip your fingers into the cream and slather it all over your [pc.skinFurScales], making sure to get those hard-to-reach places and under your folds of fat. It quickly dries off leaving you covered in a thin membrane that makes you look like you are permanently oiled.");
					//both tone and thickness less than 75
					} else {
						output(" You ");
						if(target.hasArmor() || target.hasUpperGarment()) {
							output(" strip off most of your gear");
							if (target.hasLowerGarment()) output(", leaving only your [pc.lowerGarments],");
							output(" and");
						}
						output(" strike a pose");
						if(!(target.hasArmor() || target.hasUpperGarment()) && target.hasLowerGarment()) output(", with only your [pc.lowergarments] on,");
						
						output(" so everyone can see your " + target.allChestDesc() + " and [pc.belly].");
						output(" The jar is difficult to open, but with a strong grip, some quick twists and quite a few tries later, you can slather the creamy product all over your [pc.skinFurScales]. It quickly dries, leaving you covered in a thin membrane that makes you look like you’re soaked in oil.");
					}
				}
				//apply statuseffect and store current tone in the first value
				target.createStatusEffect("Pump Up Cream", target.tone, 0, 0, 0, false, "Pill", "Your chest is covered by a thin membrane of PUMP UP!, its microsurgeons working hard on improving your muscle mass. You will have to remove it before you can apply another dose.  You can remove it at any point via the \"Remove P.Up\" command in the \"Masturbation\" menu, but the cream will still be consumed. It's one use only.", false, 4320, 0xB793C4);
				
			} else {
				kGAMECLASS.output(target.capitalA + target.short + " uses the pads, but nothing happens.");
			}
			return false;
		}

	}
}
