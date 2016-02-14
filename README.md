# Effects

A `CoreGraphics` and `CoreAnimation` experiment.

To use one of the custom `UIView` subclasses, simply add a `UIView` to a Storyboard scene and set the `UIView`'s class in the Identity Inspector. Set the `IBInspectable` properties and enjoy! 

You can also create one and add it to the view heirarchy manually:

```
let starfieldView = StarfieldView(frame: self.view.frame)
starfieldView.starColor = UIColor.whiteColor()
starfieldView.canvasColor = UIColor.blackColor()
view.addSubview(starfieldView)
```

Here's what `StarfieldView` looks like:

![StarfieldView in action.](starfield-view.gif)