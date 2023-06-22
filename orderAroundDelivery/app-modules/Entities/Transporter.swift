/* 
Copyright (c) 2018 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar

*/

import Foundation
struct Transporter : Codable {
	let id : Int?
	let name : String?
	let email : String?
	let phone : String?
	let avatar : String?
	let address : String?
	let latitude : Double?
	let longitude : Double?
	let otp : String?
	let rating : Int?
	let device_token : String?
	let device_id : String?
	let device_type : String?
	let status : String?

	enum CodingKeys: String, CodingKey {

		case id = "id"
		case name = "name"
		case email = "email"
		case phone = "phone"
		case avatar = "avatar"
		case address = "address"
		case latitude = "latitude"
		case longitude = "longitude"
		case otp = "otp"
		case rating = "rating"
		case device_token = "device_token"
		case device_id = "device_id"
		case device_type = "device_type"
		case status = "status"
	}

	init(from decoder: Decoder) throws {
		let values = try decoder.container(keyedBy: CodingKeys.self)
		id = try values.decodeIfPresent(Int.self, forKey: .id)
		name = try values.decodeIfPresent(String.self, forKey: .name)
		email = try values.decodeIfPresent(String.self, forKey: .email)
		phone = try values.decodeIfPresent(String.self, forKey: .phone)
		avatar = try values.decodeIfPresent(String.self, forKey: .avatar)
		address = try values.decodeIfPresent(String.self, forKey: .address)
		latitude = try values.decodeIfPresent(Double.self, forKey: .latitude)
		longitude = try values.decodeIfPresent(Double.self, forKey: .longitude)
		otp = try values.decodeIfPresent(String.self, forKey: .otp)
		rating = try values.decodeIfPresent(Int.self, forKey: .rating)
		device_token = try values.decodeIfPresent(String.self, forKey: .device_token)
		device_id = try values.decodeIfPresent(String.self, forKey: .device_id)
		device_type = try values.decodeIfPresent(String.self, forKey: .device_type)
		status = try values.decodeIfPresent(String.self, forKey: .status)
	}

}