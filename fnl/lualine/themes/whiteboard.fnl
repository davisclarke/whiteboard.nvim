(local whiteboard (. (require (.. :whiteboard)) :palette))

(local colors {:color0 whiteboard.bg
               :color1 whiteboard.yellow
               :color2 whiteboard.magenta
               :color3 whiteboard.base01
               :color6 whiteboard.fg
               :color7 whiteboard.red
               :color8 whiteboard.green
               :color9 whiteboard.purple
               :color10 whiteboard.orange})

{:replace {:a {:fg (. colors :color0) :bg (. colors :color1)}
           :b {:fg (. colors :color2) :bg (. colors :color3)}}
 :inactive {:a {:fg (. colors :color0) :bg (. colors :color7)}
            :b {:fg (. colors :color6) :bg (. colors :color3)}
            :z {:fg (. colors :color0) :bg (. colors :color3)}}
 :normal {:a {:fg (. colors :color0) :bg (. colors :color7)}
          :b {:fg (. colors :color6) :bg (. colors :color3)}
          :c {:fg (. colors :color6) :bg (. colors :color3)}
          :z {:fg (. colors :color6) :bg (. colors :color3)}}
 :visual {:a {:fg (. colors :color0) :bg (. colors :color8)}
          :b {:fg (. colors :color6) :bg (. colors :color3)}
          :y {:fg (. colors :color6) :bg (. colors :color3)}
          :z {:fg (. colors :color9) :bg (. colors :color3)}}
 :insert {:a {:fg (. colors :color0) :bg (. colors :color9)}
          :b {:fg (. colors :color6) :bg (. colors :color3)}
          :z {:fg (. colors :color9) :bg (. colors :color3)}}
 :command {:a {:fg (. colors :color0) :bg (. colors :color10)}}}
