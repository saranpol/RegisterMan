//
//  CellRegister.m
//  RegisterMan
//
//  Created by saranpol on 10/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CellRegister.h"


@implementation CellRegister

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code.
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state.
}


- (void)dealloc {
    [super dealloc];
}


@end
