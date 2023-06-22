/* 
Copyright (c) 2018 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct OrderAddress : Codable {
	let id : Int?
	let user_id : Int?
	let building : String?
	let street : String?
	let city : String?
	let state : String?
	let country : String?
	let pincode : String?
	let landmark : String?
	let map_address : String?
	let latitude : Double?
	let longitude : Double?
	let type : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case user_id = "user_id"
		case building = "building"
		case street = "street"
		case city = "city"
		case state = "state"
		case country = "country"
		case pincode = "pincode"
		case landmark = "landmark"
		case map_address = "map_address"
		case latitude = "latitude"
		case longitude = "longitude"
		case type = "type"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		user_id = try values.decodeIfPresent(Int.self, forKey: .user_id)
		building = try values.decodeIfPresent(String.self, forKey: .building)
		street = try values.decodeIfPresent(String.self, forKey: .street)
		city = try values.decodeIfPresent(String.self, forKey: .city)
		state = try values.decodeIfPresent(String.self, forKey: .state)
		country = try values.decodeIfPresent(String.self, forKey: .country)
		pincode = try values.decodeIfPresent(String.self, forKey: .pincode)
		landmark = try values.decodeIfPresent(String.self, forKey: .landmark)
		map_address = try values.decodeIfPresent(String.self, forKey: .map_address)
		latitude = try values.decodeIfPresent(Double.self, forKey: .latitude)
		longitude = try values.decodeIfPresent(Double.self, forKey: .longitude)
		type = try values.decodeIfPresent(String.self, forKey: .type)
	}

}

struct Reviewrating : Codable {
    let id : Int?
    let order_id : Int?
    let user_id : Int?
    let user_rating : Int?
    let user_comment : String?
    let transporter_id : Int?
    let transporter_rating : Int?
    let transporter_comment : String?
    let shop_id : Int?
    let shop_rating : Int?
    let shop_comment : String?

    enum CodingKeys: String, CodingKey {
        
        case id = "id"
        case order_id = "order_id"
        case user_id = "user_id"
        case user_rating = "user_rating"
        case user_comment = "user_comment"
        case transporter_id = "transporter_id"
        case transporter_rating = "transporter_rating"
        case transporter_comment = "transporter_comment"
        case shop_id = "shop_id"
        case shop_rating = "shop_rating"
        case shop_comment = "shop_comment"
       
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decodeIfPresent(Int.self, forKey: .id)
        order_id = try values.decodeIfPresent(Int.self, forKey: .order_id)
        user_id = try values.decodeIfPresent(Int.self, forKey: .user_id)
        user_rating = try values.decodeIfPresent(Int.self, forKey: .user_rating)
        user_comment = try values.decodeIfPresent(String.self, forKey: .user_comment)
        transporter_id = try values.decodeIfPresent(Int.self, forKey: .transporter_id)
        transporter_rating = try values.decodeIfPresent(Int.self, forKey: .transporter_rating)
        transporter_comment = try values.decodeIfPresent(String.self, forKey: .transporter_comment)
        shop_id = try values.decodeIfPresent(Int.self, forKey: .shop_id)
        shop_rating = try values.decodeIfPresent(Int.self, forKey: .shop_rating)
        shop_comment = try values.decodeIfPresent(String.self, forKey: .shop_comment)
    }
    
}
