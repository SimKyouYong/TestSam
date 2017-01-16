//
//  PopupListHalf.m
//  Coffee_iOS
//
//  Created by Joseph_iMac on 2017. 1. 16..
//  Copyright © 2017년 JC1_Joseph. All rights reserved.
//

#import "PopupListHalf.h"

@implementation PopupListHalf

+ (NSMutableArray*)list:(NSString*)name{
    NSMutableArray *listArr = [[NSMutableArray alloc] init];
    
    if([name isEqualToString:@"Floral"]){
        [listArr addObject:@"Floral"];
        [listArr addObject:@"rose"];
        [listArr addObject:@"chamomile"];
        [listArr addObject:@"jasmine"];
        
    }else if([name isEqualToString:@"Fruity"]){
        [listArr addObject:@"Fruity"];
        
    }else if([name isEqualToString:@"citrus"]){
        [listArr addObject:@"citrus"];
        [listArr addObject:@"lemon"];
        [listArr addObject:@"lime"];
        [listArr addObject:@"orange"];
        [listArr addObject:@"grape fruit"];
        [listArr addObject:@"tangerine"];
        
    }else if([name isEqualToString:@"apple"]){
        [listArr addObject:@"apple"];
        [listArr addObject:@"green apple"];
        [listArr addObject:@"red apple"];
        
    }else if([name isEqualToString:@"melon"]){
        [listArr addObject:@"melon"];
        
    }else if([name isEqualToString:@"tropical fruit"]){
        [listArr addObject:@"tropical fruit"];
        [listArr addObject:@"lychee"];
        [listArr addObject:@"passion fruit"];
        [listArr addObject:@"mango"];
        [listArr addObject:@"banana"];
        [listArr addObject:@"coconut"];
        [listArr addObject:@"pineapple"];
        
    }else if([name isEqualToString:@"stone fruit"]){
        [listArr addObject:@"stone fruit"];
        [listArr addObject:@"peach"];
        [listArr addObject:@"plum"];
        [listArr addObject:@"apricot"];
        
    }else if([name isEqualToString:@"berry"]){
        [listArr addObject:@"berry"];
        [listArr addObject:@"cranberry"];
        [listArr addObject:@"strawberry"];
        [listArr addObject:@"blueberry"];
        [listArr addObject:@"black currant"];
        
    }else if([name isEqualToString:@"grape/wine"]){
        [listArr addObject:@"grape/wine"];
        [listArr addObject:@"green grape"];
        [listArr addObject:@"red grape"];
        
    }else if([name isEqualToString:@"dried fruit"]){
        [listArr addObject:@"dried fruit"];
        [listArr addObject:@"raisin"];
        [listArr addObject:@"dried dates"];
        [listArr addObject:@"prune"];
        
    }else if([name isEqualToString:@"Herb/Vegetative"]){
        [listArr addObject:@"Herb/Vegetative"];
        [listArr addObject:@"cedar"];
        [listArr addObject:@"mint"];
        [listArr addObject:@"green tea"];
        [listArr addObject:@"lemongrass"];
        [listArr addObject:@"black tea"];
        [listArr addObject:@"bergamot"];
        [listArr addObject:@"root"];
        [listArr addObject:@"tomato"];
        
    }else if([name isEqualToString:@"Spice"]){
        [listArr addObject:@"Spice"];
        [listArr addObject:@"black pepper"];
        [listArr addObject:@"cinnamon"];
        [listArr addObject:@"coriander"];
        [listArr addObject:@"ginger"];
        [listArr addObject:@"nutmeg"];
        [listArr addObject:@"licorice"];
        [listArr addObject:@"anise star"];
        
    }else if([name isEqualToString:@"Sweet"]){
        [listArr addObject:@"Sweet"];
        [listArr addObject:@"vanilla"];
        [listArr addObject:@"honey"];
        [listArr addObject:@"marshmallow"];
        [listArr addObject:@"sugar cane"];
        [listArr addObject:@"caramel"];
        [listArr addObject:@"maple syrup"];
        [listArr addObject:@"molasses(grain syrup)"];
        
    }else if([name isEqualToString:@"Nut"]){
        [listArr addObject:@"Nut"];
        [listArr addObject:@"walnut"];
        [listArr addObject:@"peanut"];
        [listArr addObject:@"cashew"];
        [listArr addObject:@"hazelnut"];
        [listArr addObject:@"macadamia"];
        [listArr addObject:@"almond"];
        
    }else if([name isEqualToString:@"Chocolate"]){
        [listArr addObject:@"Chocolate"];
        [listArr addObject:@"dark chocolate"];
        [listArr addObject:@"milk chocolate"];
        
    }else if([name isEqualToString:@"Grain/Cereal"]){
        [listArr addObject:@"Grain/Cereal"];
        [listArr addObject:@"Mixed grain powder"];
        [listArr addObject:@"rye"];
        [listArr addObject:@"buck wheat"];
        [listArr addObject:@"barley/malt"];
        
    }else if([name isEqualToString:@"Roast"]){
        [listArr addObject:@"Roast"];
        [listArr addObject:@"toast"];
        [listArr addObject:@"burnt sugar"];
        [listArr addObject:@"smoky"];
        
    }else if([name isEqualToString:@"Savory"]){
        [listArr addObject:@"Savory"];
        [listArr addObject:@"seasoning"];
        [listArr addObject:@"meat-like"];
        [listArr addObject:@"soy sauce"];
        
    }else if([name isEqualToString:@"fermented"]){
        [listArr addObject:@"fermented"];
        [listArr addObject:@"coffee pulp(overripe)"];
        
    }else if([name isEqualToString:@"chemical"]){
        [listArr addObject:@"chemical"];
        
    }else if([name isEqualToString:@"phenolic"]){
        [listArr addObject:@"phenolic"];
        [listArr addObject:@"rioy"];
        [listArr addObject:@"medicine"];
        
    }else if([name isEqualToString:@"ashy"]){
        [listArr addObject:@"ashy"];
        
    }else if([name isEqualToString:@"rubbery"]){
        [listArr addObject:@"rubbery"];
        
    }else if([name isEqualToString:@"rest metal(녹슨쇠)"]){
        [listArr addObject:@"rest metal(녹슨쇠)"];
        
    }else if([name isEqualToString:@"Green/grassy"]){
        [listArr addObject:@"Green/grassy"];
        [listArr addObject:@"green"];
        [listArr addObject:@"hay/strawy"];
        [listArr addObject:@"woody"];
        [listArr addObject:@"paper"];
        [listArr addObject:@"ginseng"];
        [listArr addObject:@"quaker"];
        [listArr addObject:@"potato"];
        
    }else if([name isEqualToString:@"musty"]){
        [listArr addObject:@"musty"];
        [listArr addObject:@"moldy"];
        [listArr addObject:@"dirty(dusty)"];
        [listArr addObject:@"stone"];
        [listArr addObject:@"wet soil"];
        
    }else if([name isEqualToString:@"Roast Defect"]){
        [listArr addObject:@"Roast Defect"];
        [listArr addObject:@"bake"];
        [listArr addObject:@"scorched"];
        
    }else if([name isEqualToString:@"Acidity_Po"]){
        [listArr addObject:@"bright"];
        [listArr addObject:@"juicy"];
        [listArr addObject:@"delicate(mild)"];
        [listArr addObject:@"clean"];
        
    }else if([name isEqualToString:@"Acidity_Ne"]){
        [listArr addObject:@"Sharp"];
        [listArr addObject:@"sour"];
        [listArr addObject:@"muted"];
        
    }else if([name isEqualToString:@"Aftertaste_Po"]){
        [listArr addObject:@"clean"];
        [listArr addObject:@"lingering(long lasting)"];
        [listArr addObject:@"after sweet"];
        
    }else if([name isEqualToString:@"Aftertaste_Ne"]){
        [listArr addObject:@"muted"];
        [listArr addObject:@"dirty"];
        [listArr addObject:@"dry"];
        [listArr addObject:@"rough(astrigent)"];
        [listArr addObject:@"unpleasent bitter"];
        
    }else if([name isEqualToString:@"Body_Light"]){
        [listArr addObject:@"light"];
        
    }else if([name isEqualToString:@"Body_Medium"]){
        [listArr addObject:@"medium"];
        
    }else if([name isEqualToString:@"Body_Heavy"]){
        [listArr addObject:@"heavy"];
        
    }else if([name isEqualToString:@"Balance_Po"]){
        [listArr addObject:@"complex"];
        [listArr addObject:@"structured"];
        [listArr addObject:@"balanced"];
        
    }else if([name isEqualToString:@"Balance_Ne"]){
        [listArr addObject:@"unbalanced"];
        [listArr addObject:@"flat"];
        
    }else if([name isEqualToString:@"Mouthfeel_Po"]){
        [listArr addObject:@"smoth"];
        [listArr addObject:@"round"];
        [listArr addObject:@"creamy"];
        [listArr addObject:@"velvety"];
        
    }else if([name isEqualToString:@"Mouthfeel_Ne"]){
        [listArr addObject:@"watery"];
        [listArr addObject:@"slick"];
        [listArr addObject:@"oily"];
        [listArr addObject:@"powdery"];
    }
    
    return listArr;
}

@end
