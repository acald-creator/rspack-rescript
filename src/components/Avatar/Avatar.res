open Emotion.Css
open Emotion.Utils

module Avatar = {
  type size = [#sm | #md | #lg]

  @react.component
  let make = (~name: string, ~src: option<string>=?, ~size: size=#md, ~className: string="", ()) => {
    let dimension = switch size {
    | #sm => "2rem"
    | #md => "2.5rem"
    | #lg => "3.5rem"
    }

    let fontSize = switch size {
    | #sm => "0.75rem"
    | #md => "0.875rem"
    | #lg => "1.125rem"
    }

    let baseStyles = css({
      "width": dimension,
      "height": dimension,
      "borderRadius": "50%",
      "display": "inline-flex",
      "alignItems": "center",
      "justifyContent": "center",
      "flexShrink": "0",
      "overflow": "hidden",
      "backgroundColor": Color.bgElevated,
      "border": `1px solid ${Color.border}`,
      "color": Color.textSecondary,
      "fontSize": fontSize,
      "fontWeight": "500",
      "letterSpacing": "0.05em",
      "textTransform": "uppercase",
    })

    let imgStyles = css({
      "width": "100%",
      "height": "100%",
      "objectFit": "cover",
    })

    let initials =
      name
      ->String.split(" ")
      ->Array.filterMap(part => part->String.charAt(0)->Some)
      ->Array.slice(~start=0, ~end=2)
      ->Array.join("")

    let avatarClassName = cx([baseStyles, className])

    <div className={avatarClassName}>
      {switch src {
      | Some(url) => <img className={imgStyles} src={url} alt={name} />
      | None => React.string(initials)
      }}
    </div>
  }
}
