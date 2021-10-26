//Human Overlays Indexes/////////
#define MUTATIONS_LAYER			31		//! mutations. Tk headglows, cold resistance glow, etc
#define BODY_BEHIND_LAYER		30		//! certain mutantrace features (tail when looking south) that must appear behind the body parts
#define BODYPARTS_LAYER			29		//! Initially "AUGMENTS", this was repurposed to be a catch-all bodyparts flag
#define MARKING_LAYER			28		//Matrixed body markings because clashing with snouts?
#define BODY_ADJ_LAYER			27		//! certain mutantrace features (snout, body markings) that must appear above the body parts
#define BODY_LAYER				26		//! underwear, undershirts, socks, eyes, lips(makeup)
#define FRONT_MUTATIONS_LAYER	25		//! mutations that should appear above body, body_adj and bodyparts layer (e.g. laser eyes)
#define DAMAGE_LAYER			24		//! damage indicators (cuts and burns)
#define UNIFORM_LAYER			23
#define ID_LAYER				22 		//! lmao at the idiot who put both ids and hands on the same layer
#define HANDS_PART_LAYER		21
#define GLOVES_LAYER			20
#define SHOES_LAYER				19
#define EARS_LAYER				18
#define BODY_TAUR_LAYER			17
#define SUIT_LAYER				16
#define GLASSES_LAYER			15
#define BELT_LAYER				14		//! Possible make this an overlay of somethign required to wear a belt?
#define SUIT_STORE_LAYER		13
#define NECK_LAYER				12
#define BACK_LAYER				11
#define HAIR_LAYER				10		//! TODO: make part of head layer?
#define FACEMASK_LAYER			9
#define HEAD_LAYER				8
#define HANDCUFF_LAYER			7
#define LEGCUFF_LAYER			6
#define HANDS_LAYER				5
#define BODY_FRONT_LAYER		4
#define SMELL_LAYER				3
#define HALO_LAYER				2		//! blood cult ascended halo, because there's currently no better solution for adding/removing
#define FIRE_LAYER				1		//! If you're on fire
#define TOTAL_LAYERS			31		//! KEEP THIS UP-TO-DATE OR SHIT WILL BREAK ;_;
