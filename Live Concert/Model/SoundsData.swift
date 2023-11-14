//
//  SoundsData.swift
//  Sleep Sounds
//
//  Created by Aziz Bibitov on 16.03.2022.
//

import Foundation
struct SoundsData{
    var sounds_data = [
        Sound(id: 0, sound_name: "Heavy Rain", sound_image: "heavy rain", sound_filename: "rain heavy", sound_volume: 0.0, sound_category: "Rain & Thunder", is_sound_premium: false),
        Sound(id: 1, sound_name: "Light Rain", sound_image: "light rain", sound_filename: "rain light", sound_volume: 0.0, sound_category: "Rain & Thunder", is_sound_premium: false),
        Sound(id: 2, sound_name: "Rain on Leaves", sound_image: "rain on leaf", sound_filename: "rain on leaves premium", sound_volume: 0.0, sound_category: "Rain & Thunder", is_sound_premium: true),
        Sound(id: 3, sound_name: "Rain on Roof", sound_image: "rain on roof", sound_filename: "rain on roof", sound_volume: 0.0, sound_category: "Rain & Thunder", is_sound_premium: false),
        Sound(id: 4, sound_name: "Rain on Window", sound_image: "rain on window", sound_filename: "rain on window premium", sound_volume: 0.0, sound_category: "Rain & Thunder", is_sound_premium: true),
        Sound(id: 5, sound_name: "Snowstorm", sound_image: "snow", sound_filename: "snow premium", sound_volume: 0.0, sound_category: "Rain & Thunder", is_sound_premium: true),
        
        
        
        Sound(id: 6, sound_name: "Beach", sound_image: "beach", sound_filename: "beach", sound_volume: 0.0, sound_category: "Nature", is_sound_premium: false),
        Sound(id: 7, sound_name: "Desert Night", sound_image: "desert night", sound_filename: "desert night premium", sound_volume: 0.0, sound_category: "Nature", is_sound_premium: true),
        Sound(id: 8, sound_name: "Fire", sound_image: "fire", sound_filename: "fire", sound_volume: 0.0, sound_category: "Nature", is_sound_premium: false),
        Sound(id: 9, sound_name: "Forest Night", sound_image: "forest night", sound_filename: "forest", sound_volume: 0.0, sound_category: "Nature", is_sound_premium: false),
        Sound(id: 10, sound_name: "Forest", sound_image: "forest", sound_filename: "forest premium", sound_volume: 0.0, sound_category: "Nature", is_sound_premium: true),
        Sound(id: 11, sound_name: "Jungle Night", sound_image: "jungle night", sound_filename: "jungle night premium", sound_volume: 0.0, sound_category: "Nature", is_sound_premium: true),
        Sound(id: 12, sound_name: "Jungle", sound_image: "jungle", sound_filename: "jungle", sound_volume: 0.0, sound_category: "Nature", is_sound_premium: false),
        Sound(id: 13, sound_name: "Lake", sound_image: "lake", sound_filename: "lake", sound_volume: 0.0, sound_category: "Nature", is_sound_premium: false),
        Sound(id: 14, sound_name: "Ocean", sound_image: "ocean wave", sound_filename: "ocean", sound_volume: 0.0, sound_category: "Nature", is_sound_premium: false),
        Sound(id: 15, sound_name: "Waterfall", sound_image: "waterfall", sound_filename: "waterfall premium", sound_volume: 0.0, sound_category: "Nature", is_sound_premium: true),
        Sound(id: 16, sound_name: "Wind Leaves", sound_image: "wind leaves", sound_filename: "wind leaves premium", sound_volume: 0.0, sound_category: "Nature", is_sound_premium: true),
        Sound(id: 17, sound_name: "Wind", sound_image: "wind", sound_filename: "windstorm premium", sound_volume: 0.0, sound_category: "Nature", is_sound_premium: false),
        
        Sound(id: 18, sound_name: "Bird", sound_image: "bird", sound_filename: "bird", sound_volume: 0.0, sound_category: "Birds", is_sound_premium: false),
        Sound(id: 19, sound_name: "Cricket", sound_image: "cricket", sound_filename: "Crickets", sound_volume: 0.0, sound_category: "Animals", is_sound_premium: false),
        Sound(id: 20, sound_name: "Forest Birds", sound_image: "forest birds", sound_filename: "forest birds premium", sound_volume: 0.0, sound_category: "Birds", is_sound_premium: true),
        Sound(id: 21, sound_name: "Frog", sound_image: "frog", sound_filename: "frog", sound_volume: 0.0, sound_category: "Animals", is_sound_premium: false),
        Sound(id: 22, sound_name: "Owl", sound_image: "owl", sound_filename: "owl premium", sound_volume: 0.0, sound_category: "Birds", is_sound_premium: true),
        Sound(id: 23, sound_name: "Seagull", sound_image: "seagull", sound_filename: "seagull", sound_volume: 0.0, sound_category: "Birds", is_sound_premium: false),
        Sound(id: 24, sound_name: "Tropical Birds", sound_image: "tropical birds", sound_filename: "tropical birds", sound_volume: 0.0, sound_category: "Birds", is_sound_premium: false),
        Sound(id: 25, sound_name: "Whale", sound_image: "whale", sound_filename: "whale premium", sound_volume: 0.0, sound_category: "Animals", is_sound_premium: true),
        Sound(id: 26, sound_name: "Wolf", sound_image: "wolf", sound_filename: "wolf premium", sound_volume: 0.0, sound_category: "Animals", is_sound_premium: true),
        
        Sound(id: 27, sound_name: "Driving", sound_image: "driving", sound_filename: "driving premium", sound_volume: 0.0, sound_category: "City & Transport", is_sound_premium: true),
        Sound(id: 28, sound_name: "Firework", sound_image: "firework explosion", sound_filename: "firework", sound_volume: 0.0, sound_category: "City & Transport", is_sound_premium: false),
        Sound(id: 29, sound_name: "Flight", sound_image: "flight", sound_filename: "flight", sound_volume: 0.0, sound_category: "City & Transport", is_sound_premium: false),
        Sound(id: 30, sound_name: "Street", sound_image: "street", sound_filename: "street premium", sound_volume: 0.0, sound_category: "City & Transport", is_sound_premium: true),
        Sound(id: 31, sound_name: "Train", sound_image: "train", sound_filename: "train premium", sound_volume: 0.0, sound_category: "City & Transport", is_sound_premium: true),
        
        Sound(id: 32, sound_name: "Meditation", sound_image: "meditation", sound_filename: "meditation premium", sound_volume: 0.0, sound_category: "Meditation", is_sound_premium: true),
        Sound(id: 33, sound_name: "Zen", sound_image: "zen", sound_filename: "zen", sound_volume: 0.0, sound_category: "Meditation", is_sound_premium: false),
        
        Sound(id: 34, sound_name: "Thunder", sound_image: "thunder", sound_filename: "thunder", sound_volume: 0.0, sound_category: "Rain & Thunder", is_sound_premium: false),
    ]
}





//Sound(id: 0, sound_name: "Beach", sound_image: "beach-33", sound_filename: "ocean_waves", sound_volume: 0.5, sound_category: "General", is_sound_premium: false),
//Sound(id: 1, sound_name: "Birds", sound_image: "bird-33", sound_filename: "jungle_night", sound_volume: 0.5, sound_category: "General"),
//Sound(id: 2, sound_name: "Relax", sound_image: "sofa-33", sound_filename: "fireplace", sound_volume: 0.5, sound_category: "General"),
//Sound(id: 3, sound_name: "Rain", sound_image: "rainy-weather-33", sound_filename: "light_rain", sound_volume: 0.5, sound_category: "General"),
//Sound(id: 4, sound_name: "Beach", sound_image: "beach-33", sound_filename: "ocean_waves", sound_volume: 0.5, sound_category: "General"),
//Sound(id: 5, sound_name: "Birds", sound_image: "bird-33", sound_filename: "jungle_night", sound_volume: 0.5, sound_category: "General"),
//Sound(id: 6, sound_name: "Relax", sound_image: "sofa-33", sound_filename: "fireplace", sound_volume: 0.5, sound_category: "General"),
//Sound(id: 7, sound_name: "Rain", sound_image: "rainy-weather-33", sound_filename: "light_rain", sound_volume: 0.5, sound_category: "General"),
//Sound(id: 8, sound_name: "Beach", sound_image: "beach-33", sound_filename: "ocean_waves", sound_volume: 0.5, sound_category: "General"),
//Sound(id: 9, sound_name: "Birds", sound_image: "bird-33", sound_filename: "jungle_night", sound_volume: 0.5, sound_category: "General"),
//Sound(id: 10, sound_name: "Relax", sound_image: "sofa-33", sound_filename: "fireplace", sound_volume: 0.5, sound_category: "General"),
//Sound(id: 11, sound_name: "Rain", sound_image: "rainy-weather-33", sound_filename: "light_rain", sound_volume: 0.5, sound_category: "General"),
//
//
//Sound(id: 12, sound_name: "Beach", sound_image: "beach-33", sound_filename: "ocean_waves", sound_volume: 0.5, sound_category: "Nature"),
//Sound(id: 13, sound_name: "Birds", sound_image: "bird-33", sound_filename: "jungle_night", sound_volume: 0.5, sound_category: "Nature"),
//Sound(id: 14, sound_name: "Relax", sound_image: "sofa-33", sound_filename: "fireplace", sound_volume: 0.5, sound_category: "Nature"),
//Sound(id: 15, sound_name: "Rain", sound_image: "rainy-weather-33", sound_filename: "light_rain", sound_volume: 0.5, sound_category: "Nature"),
//Sound(id: 16, sound_name: "Beach", sound_image: "beach-33", sound_filename: "ocean_waves", sound_volume: 0.5, sound_category: "Nature"),
//Sound(id: 17, sound_name: "Birds", sound_image: "bird-33", sound_filename: "jungle_night", sound_volume: 0.5, sound_category: "Nature"),
//Sound(id: 18, sound_name: "Relax", sound_image: "sofa-33", sound_filename: "fireplace", sound_volume: 0.5, sound_category: "Nature"),
//
//Sound(id: 19, sound_name: "Birds", sound_image: "bird-33", sound_filename: "jungle_night", sound_volume: 0.5, sound_category: "Birds"),
//Sound(id: 20, sound_name: "Relax", sound_image: "sofa-33", sound_filename: "fireplace", sound_volume: 0.5, sound_category: "Birds"),
//Sound(id: 21, sound_name: "Rain", sound_image: "rainy-weather-33", sound_filename: "light_rain", sound_volume: 0.5, sound_category: "Birds"),//For Reset
