//
//  MovieCastAndCrew.swift
//  MoviesApp
//
//  Created by Prashant Tukadiya on 06/09/23.
//

import Foundation

// MARK: - Welcome
struct MovieCastCrewResponse: Codable {
    let id: Int
    let cast :[Cast]
    let  crew: [Cast]
}

// MARK: - Cast
struct Cast: Codable,Identifiable {
    let adult: Bool
    let gender, id: Int
    let knownForDepartment: String?
    let name, originalName: String
    let popularity: Double
    let profilePath: String?
    let castID: Int?
    let character: String?
    let creditID: String
    let order: Int?
    let department: String?
    let job: String?
    

    enum CodingKeys: String, CodingKey {
        case adult, gender, id
        case knownForDepartment = "known_for_department"
        case name
        case originalName = "original_name"
        case popularity
        case profilePath = "profile_path"
        case castID = "cast_id"
        case character
        case creditID = "credit_id"
        case order, department, job
    }
}

extension Cast{
    
    var profileImage:String? {
        if let profilePath {
            return Constants.imageBaseURL200 + profilePath
        }
        return nil
    }
}

//enum Department: String, Codable {
//    case acting = "Acting"
//    case art = "Art"
//    case camera = "Camera"
//    case costumeMakeUp = "Costume & Make-Up"
//    case crew = "Crew"
//    case directing = "Directing"
//    case editing = "Editing"
//    case lighting = "Lighting"
//    case production = "Production"
//    case sound = "Sound"
//    case writing = "Writing"
//}


extension MovieCastCrewResponse {
    
    private static let defaultData =
    """
    {
      "id": 110,
      "cast": [
        {
          "adult": false,
          "gender": 1,
          "id": 1350,
          "known_for_department": "Acting",
          "name": "Irène Jacob",
          "original_name": "Irène Jacob",
          "popularity": 10.013,
          "profile_path": "/yDpLjFtglSDlq3pvITr7O5AQfvg.jpg",
          "cast_id": 9,
          "character": "Valentine Dussaut",
          "credit_id": "52fe4219c3a36847f8003da9",
          "order": 0
        },
        {
          "adult": false,
          "gender": 2,
          "id": 1352,
          "known_for_department": "Acting",
          "name": "Jean-Louis Trintignant",
          "original_name": "Jean-Louis Trintignant",
          "popularity": 6.352,
          "profile_path": "/wn6owr4wvkeaEvlsPtwXSldFGEW.jpg",
          "cast_id": 10,
          "character": "Richter Joseph Kern",
          "credit_id": "52fe4219c3a36847f8003dad",
          "order": 1
        },
        {
          "adult": false,
          "gender": 2,
          "id": 1356,
          "known_for_department": "Acting",
          "name": "Jean-Pierre Lorit",
          "original_name": "Jean-Pierre Lorit",
          "popularity": 2.257,
          "profile_path": "/kE57M7P23r3w2UDCAaUPXLEzOwI.jpg",
          "cast_id": 12,
          "character": "Auguste Bruner",
          "credit_id": "52fe4219c3a36847f8003db1",
          "order": 2
        },
        {
          "adult": false,
          "gender": 1,
          "id": 1354,
          "known_for_department": "Acting",
          "name": "Frédérique Feder",
          "original_name": "Frédérique Feder",
          "popularity": 1.706,
          "profile_path": "/vHCAJPYuFb2JJeX18yVo8hJmQeY.jpg",
          "cast_id": 16,
          "character": "Karin",
          "credit_id": "52fe4219c3a36847f8003dc7",
          "order": 3
        },
        {
          "adult": false,
          "gender": 2,
          "id": 49025,
          "known_for_department": "Acting",
          "name": "Samuel Le Bihan",
          "original_name": "Samuel Le Bihan",
          "popularity": 2.569,
          "profile_path": "/fQSmkGMIc10vGekaXV7Fr0ThRms.jpg",
          "cast_id": 17,
          "character": "Photographer",
          "credit_id": "52fe4219c3a36847f8003dcb",
          "order": 4
        },
        {
          "adult": false,
          "gender": 1,
          "id": 27983,
          "known_for_department": "Acting",
          "name": "Marion Stalens",
          "original_name": "Marion Stalens",
          "popularity": 1.48,
          "profile_path": "/8AEcShsEooBHYwneHUHyL65mtxO.jpg",
          "cast_id": 18,
          "character": "Veterinarian",
          "credit_id": "52fe4219c3a36847f8003dcf",
          "order": 5
        },
        {
          "adult": false,
          "gender": 2,
          "id": 73873,
          "known_for_department": "Acting",
          "name": "Teco Celio",
          "original_name": "Teco Celio",
          "popularity": 6.006,
          "profile_path": "/5PUIFW0JvgoaLX1ndyJbSeBdQF0.jpg",
          "cast_id": 28,
          "character": "Bartender",
          "credit_id": "5cb2101fc3a3683c24ae85ae",
          "order": 6
        },
        {
          "adult": false,
          "gender": 0,
          "id": 2276196,
          "known_for_department": "Acting",
          "name": "Bernard Escalon",
          "original_name": "Bernard Escalon",
          "popularity": 0.98,
          "profile_path": "/hRifAJBIuQEd6xUhvVkYm4tiZOy.jpg",
          "cast_id": 29,
          "character": "Record Dealer",
          "credit_id": "5cb210480e0a2626e9c684e8",
          "order": 7
        },
        {
          "adult": false,
          "gender": 0,
          "id": 2287855,
          "known_for_department": "Acting",
          "name": "Jean Schlegel",
          "original_name": "Jean Schlegel",
          "popularity": 1.094,
          "profile_path": null,
          "cast_id": 30,
          "character": "Neighbor",
          "credit_id": "5cb2106bc3a3683c26ae3dcf",
          "order": 8
        },
        {
          "adult": false,
          "gender": 1,
          "id": 2287856,
          "known_for_department": "Acting",
          "name": "Elżbieta Jasińska",
          "original_name": "Elżbieta Jasińska",
          "popularity": 0.618,
          "profile_path": "/hcM2a714AjQXejIkhOqY30QcZQw.jpg",
          "cast_id": 31,
          "character": "Woman",
          "credit_id": "5cb210809251412fad25cd03",
          "order": 9
        },
        {
          "adult": false,
          "gender": 2,
          "id": 1145,
          "known_for_department": "Acting",
          "name": "Zbigniew Zamachowski",
          "original_name": "Zbigniew Zamachowski",
          "popularity": 3.733,
          "profile_path": "/mLntjL4Jp1LEz41NgcrHlsB7OmB.jpg",
          "cast_id": 21,
          "character": "Karol Karol",
          "credit_id": "52fe4219c3a36847f8003ddb",
          "order": 10
        },
        {
          "adult": false,
          "gender": 1,
          "id": 1137,
          "known_for_department": "Acting",
          "name": "Juliette Binoche",
          "original_name": "Juliette Binoche",
          "popularity": 13.676,
          "profile_path": "/llNGfF2gNBa1l39iqmjhZuDDzn6.jpg",
          "cast_id": 22,
          "character": "Julie Vignon",
          "credit_id": "53b1c42cc3a3682edb006a6b",
          "order": 11
        },
        {
          "adult": false,
          "gender": 1,
          "id": 1146,
          "known_for_department": "Acting",
          "name": "Julie Delpy",
          "original_name": "Julie Delpy",
          "popularity": 15.651,
          "profile_path": "/rd40f4QpAUUne3hMaUhHrZtcK2c.jpg",
          "cast_id": 23,
          "character": "Dominique",
          "credit_id": "53b1c43cc3a3682eee006a5d",
          "order": 12
        },
        {
          "adult": false,
          "gender": 2,
          "id": 1138,
          "known_for_department": "Acting",
          "name": "Benoît Régent",
          "original_name": "Benoît Régent",
          "popularity": 3.814,
          "profile_path": "/hSCNZq6w24lJUTJpRNyiVTtQ9lL.jpg",
          "cast_id": 24,
          "character": "Olivier",
          "credit_id": "53b1c699c3a3682eee006a80",
          "order": 13
        },
        {
          "adult": true,
          "gender": 2,
          "id": 1140941,
          "known_for_department": "Acting",
          "name": "Roland Carey",
          "original_name": "Roland Carey",
          "popularity": 1.62,
          "profile_path": "/jynPOZGBo9ANYHPmTvs4ygFWTWk.jpg",
          "cast_id": 32,
          "character": "Dealer",
          "credit_id": "615b1d8d8e2ba60043467229",
          "order": 14
        },
        {
          "adult": false,
          "gender": 0,
          "id": 63407,
          "known_for_department": "Acting",
          "name": "Jean-Marie Daunas",
          "original_name": "Jean-Marie Daunas",
          "popularity": 0.6,
          "profile_path": null,
          "cast_id": 33,
          "character": "Theater Keeper",
          "credit_id": "615b1d9b2dffd8004301f402",
          "order": 15
        }
      ],
      "crew": [
        {
          "adult": false,
          "gender": 2,
          "id": 1126,
          "known_for_department": "Directing",
          "name": "Krzysztof Kieślowski",
          "original_name": "Krzysztof Kieślowski",
          "popularity": 6.111,
          "profile_path": "/8wxPNOV9dg7EDHAFrRdJf6BitMl.jpg",
          "credit_id": "52fe4219c3a36847f8003dbd",
          "department": "Writing",
          "job": "Screenplay"
        },
        {
          "adult": false,
          "gender": 2,
          "id": 1126,
          "known_for_department": "Directing",
          "name": "Krzysztof Kieślowski",
          "original_name": "Krzysztof Kieślowski",
          "popularity": 6.111,
          "profile_path": "/8wxPNOV9dg7EDHAFrRdJf6BitMl.jpg",
          "credit_id": "52fe4219c3a36847f8003d81",
          "department": "Directing",
          "job": "Director"
        },
        {
          "adult": false,
          "gender": 2,
          "id": 1126,
          "known_for_department": "Directing",
          "name": "Krzysztof Kieślowski",
          "original_name": "Krzysztof Kieślowski",
          "popularity": 6.111,
          "profile_path": "/8wxPNOV9dg7EDHAFrRdJf6BitMl.jpg",
          "credit_id": "52fe4219c3a36847f8003d8d",
          "department": "Writing",
          "job": "Author"
        },
        {
          "adult": false,
          "gender": 2,
          "id": 1132,
          "known_for_department": "Writing",
          "name": "Krzysztof Piesiewicz",
          "original_name": "Krzysztof Piesiewicz",
          "popularity": 1.588,
          "profile_path": "/uFJXZtw0g9wzYmPfXMTYQ3vaT6k.jpg",
          "credit_id": "52fe4219c3a36847f8003dc3",
          "department": "Writing",
          "job": "Screenplay"
        },
        {
          "adult": false,
          "gender": 2,
          "id": 1132,
          "known_for_department": "Writing",
          "name": "Krzysztof Piesiewicz",
          "original_name": "Krzysztof Piesiewicz",
          "popularity": 1.588,
          "profile_path": "/uFJXZtw0g9wzYmPfXMTYQ3vaT6k.jpg",
          "credit_id": "52fe4219c3a36847f8003d93",
          "department": "Writing",
          "job": "Author"
        },
        {
          "adult": false,
          "gender": 2,
          "id": 1134,
          "known_for_department": "Production",
          "name": "Marin Karmitz",
          "original_name": "Marin Karmitz",
          "popularity": 0.907,
          "profile_path": "/63UAgtlG9Fz0ztRWIJRgY1xutnc.jpg",
          "credit_id": "52fe4219c3a36847f8003d87",
          "department": "Production",
          "job": "Producer"
        },
        {
          "adult": false,
          "gender": 2,
          "id": 1135,
          "known_for_department": "Sound",
          "name": "Zbigniew Preisner",
          "original_name": "Zbigniew Preisner",
          "popularity": 1.772,
          "profile_path": "/fK0wQ1sH3Sy9b3bgxrKXbi2JfS6.jpg",
          "credit_id": "52fe4219c3a36847f8003d99",
          "department": "Sound",
          "job": "Original Music Composer"
        },
        {
          "adult": false,
          "gender": 2,
          "id": 1136,
          "known_for_department": "Editing",
          "name": "Jacques Witta",
          "original_name": "Jacques Witta",
          "popularity": 0.84,
          "profile_path": "/gtYgtpEyipHtEDK6RkWxooiVynQ.jpg",
          "credit_id": "52fe4219c3a36847f8003da5",
          "department": "Editing",
          "job": "Editor"
        },
        {
          "adult": false,
          "gender": 0,
          "id": 1346,
          "known_for_department": "Sound",
          "name": "Bertrand Lenclos",
          "original_name": "Bertrand Lenclos",
          "popularity": 0.98,
          "profile_path": null,
          "credit_id": "52fe4219c3a36847f8003d9f",
          "department": "Sound",
          "job": "Original Music Composer"
        },
        {
          "adult": false,
          "gender": 2,
          "id": 19060,
          "known_for_department": "Sound",
          "name": "Jean-Claude Laureux",
          "original_name": "Jean-Claude Laureux",
          "popularity": 0.84,
          "profile_path": null,
          "credit_id": "5b86ea98c3a3683f79012866",
          "department": "Sound",
          "job": "Sound Designer"
        },
        {
          "adult": false,
          "gender": 1,
          "id": 19070,
          "known_for_department": "Costume & Make-Up",
          "name": "Corinne Jorry",
          "original_name": "Corinne Jorry",
          "popularity": 1.139,
          "profile_path": null,
          "credit_id": "5b86ea8d0e0a26111e0115e6",
          "department": "Costume & Make-Up",
          "job": "Costume Design"
        },
        {
          "adult": false,
          "gender": 2,
          "id": 33238,
          "known_for_department": "Camera",
          "name": "Piotr Sobociński",
          "original_name": "Piotr Sobociński",
          "popularity": 0.98,
          "profile_path": null,
          "credit_id": "52fe4219c3a36847f8003db7",
          "department": "Camera",
          "job": "Director of Photography"
        },
        {
          "adult": false,
          "gender": 0,
          "id": 1174114,
          "known_for_department": "Art",
          "name": "Claude Lenoir",
          "original_name": "Claude Lenoir",
          "popularity": 0.6,
          "profile_path": null,
          "credit_id": "5b86ea82c3a3683f7901283d",
          "department": "Art",
          "job": "Production Design"
        },
        {
          "adult": false,
          "gender": 2,
          "id": 2521401,
          "known_for_department": "Acting",
          "name": "Lucien Abbet",
          "original_name": "Lucien Abbet",
          "popularity": 0.6,
          "profile_path": "/otocrxZaF4Q5oJMzjqwqWgMd9pL.jpg",
          "credit_id": "63cf1bc407165000aaa0f8e0",
          "department": "Crew",
          "job": "Stunt Double"
        }
      ]
    }

    """
    
    static let previewMovie = try! JSONDecoder().decode(MovieCastCrewResponse.self, from:defaultData.data(using: .utf8)!)
}



