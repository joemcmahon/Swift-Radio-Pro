//
//  trackswift
//  Swift Radio
//
//  Created by Matthew Fecher on 7/2/15.
//  Copyright (c) 2015 MatthewFecher.com. All rights reserved.
//

import UIKit

//*****************************************************************
// Track struct
//*****************************************************************

struct Track {
	var title: String
	var artist: String
    var release: String
    var artworkImage: UIImage?
    var artworkLoaded = false
    
    init(title: String, artist: String, release: String) {
        self.title = title
        self.artist = artist
        self.release = release
    }
}
