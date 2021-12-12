//
//  DrawingsWorkouts.swift
//  USport
//
//  Created by Angelo Casolaro on 08/12/21.
//

// LINK = https://www.lexicon.com.au/blog/how-to-save-an-array-of-custom-data-types-in-core-data-with-transformable-and-nssecurecoding-in-ios
import Foundation

@objc(DrawingWorkouts)
final class DrawingWorkouts: NSSecureUnarchiveFromDataTransformer
{
    // Our class `Test` should in the allowed class list. (This is what the unarchiver uses to check for the right class)
    override static var allowedTopLevelClasses: [AnyClass]
    {
        return [Workouts.self]
    }

    /// Registers the transformer.
    public static func register()
    {
        // The name of the transformer. This is what we will use to register the transformer `ValueTransformer.setValueTrandformer(_"forName:)`.
        let name = NSValueTransformerName(rawValue: String(describing: DrawingWorkouts.self))
        let transformer = DrawingWorkouts()
        
        ValueTransformer.setValueTransformer(transformer, forName: name)
    }
}
