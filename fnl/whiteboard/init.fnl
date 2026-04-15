;;
;;                     .
;;                    / \\   +      |   .   +
;;                   /   \ \    - --+-- -
;;                  /     \' \   .  |     ;
;;                 /   `   \ ' \        --+--
;;                /   `     \    \  .     !
;;               /`       `  \ '   \  |
;;              /           ` \ ' '  \+--   + 
;;             /          ``   \   '   \
;;            /    `       ` `  \'     ' \   +  
;;           /                `  \       ' \ 
;;          /  `   `     `     `  \' '   ' /|
;;         /      ` `            ` \      / |
;;        /          `    `         \   '/  |
;;       /   `        `           `  \' /   |
;;      /________________________`____\/    |
;;     | `                `           |     |
;;     |                              | `   |
;;     |   `     `          `   `     |    `|
;;     |           `                  |     |
;;     |              `        `      |     |
;;     |                              |  `  |
;;     |   `            `          `  |     |
;;     |              `   `   `       |    `|
;;     |     `             `          |     |
;;     |                              | `   |
;;     |            `            `    |     |
;;     |            `            `    |     |
;;     |            `            `    |     |
;;     |            `            `    |     |
;;     |    `                         |     |
;;     |                              | `   |
;;     |                      `       |     |
;;     |      `    `                  |     |
;;     |              `               |   ` |
;;     |               `        `     |     |
;;     |                 `            |     |
;;     |       `                      |     |
;;     |                              |     |====
;;    =|                   `          |     |=^===
;;   ==|           `              `   | `  `/=====
;;  =%=|                            ` |    / ====
;;  ===|                              |   / =======
;;  ===|                  `           | `/ ========
;;  =^=|       `                      | / ====%====
;;  ===|___`_______________`_______`__|/ ========
;;   ===================================== =======
;;   =======%====== =======================^=====
;;   ======%%========== =======^======%%========
;;     ========^======================%====^=== 
;;
;; Davis Clarke <daviscclarke@proton.me>

(macro let! [...]
  (fn let-with-scope! [[scope] name value]
    (let [name (tostring name)
          scope (tostring scope)]
      `(tset ,(match scope
                :b `vim.b
                :w `vim.w
                :t `vim.t
                :g `vim.g) ,name ,value)))

  (match [...]
    [[scope] name value] (let-with-scope! [scope] name value)
    [name value] (let-with-scope! [:g] name value)
    _ (error "expected let! to have at least two arguments: name value")))

(macro set! [option]
  (let [option (tostring option)]
    `(tset vim.o ,option true)))

(macro custom-set-face! [name attributes colors]
  (let [definition (collect [_ attr (ipairs attributes) &into colors]
                     (tostring attr)
                     true)]
    `(vim.api.nvim_set_hl 0 ,name ,definition)))

;; reset variables

(when vim.g.colors_name
  (vim.cmd.hi :clear))

;; set defaults

(let! colors_name :whiteboard)
(set! termguicolors)

;; palette

(local palette {:bg "#f5f0e0"
                :base01 "#d5c9b9"
                :base02 "#b5a999"
                :fg "#000000"
                :base04 "#554939"
                :base05 "#554939"
                :base06 "#525252"
                :cyan "#267459"
                ;#540063
                ;;267459 237c59
                ;;197c70
                :magenta "#A02a9a"
                :red "#A80011"
                :yellow "#986908"
                :blue "#0f428e"
                :purple "#5a1083"
                :green "#107300"
                :orange "#d65100"
                :pink "#d446bb"
                :blend "#d5c9b9"
                :none :NONE})

; WIP Dark theme
; (local palette {:bg "#1d1d1d"
;                 :base04 "#e0e0e0"
;                 :base03 "#cecece"
;                 :fg "#dcd7cc"
;                 :base02 "#37474F"
;                 :base01 "#808080"
;                 :base06 "#525252"
;                 :green "#78997A"
;                 :orange "#fa8324"
;                 :purple "#90A939"
;                 :pink "#90A939"
;                 :red "#e64041"
;                 :blue "#7E90cB"
;                 :yellow "#fBC038"
;                 :magenta "#B380B0"
;                 :cyan "#8ec07c"
;                 :blend "#FAFAFA"
;                 :none :NONE})

;; terminal

(let! terminal_color_0 palette.base01)
(let! terminal_color_1 palette.red)
(let! terminal_color_2 palette.green)
(let! terminal_color_3 palette.yellow)
(let! terminal_color_4 palette.blue)
(let! terminal_color_5 palette.magenta)
(let! terminal_color_6 palette.cyan)
(let! terminal_color_7 palette.base02)
(let! terminal_color_8 palette.fg)
(let! terminal_color_9 palette.red)
(let! terminal_color_10 palette.green)
(let! terminal_color_11 palette.yellow)
(let! terminal_color_12 palette.blue)
(let! terminal_color_13 palette.magenta)
(let! terminal_color_14 palette.cyan)
(let! terminal_color_15 palette.base04)

;; editor

(custom-set-face! :ColorColumn [] {:fg palette.none :bg palette.base01})
(custom-set-face! :Cursor [] {:fg palette.bg :bg palette.base04})
(custom-set-face! :CursorLine [] {:fg palette.none :bg palette.base01})
(custom-set-face! :CursorColumn [] {:fg palette.none :bg palette.base01})
(custom-set-face! :CursorLineNr [] {:fg palette.base04 :bg palette.none})
(custom-set-face! :QuickFixLine [] {:fg palette.none :bg palette.base01})
(custom-set-face! :Error [] {:fg palette.yellow :bg palette.base01})
(custom-set-face! :LineNr [] {:fg palette.fg :bg palette.bg})
(custom-set-face! :NonText [] {:fg palette.base02 :bg palette.none})
(custom-set-face! :Normal [] {:fg palette.fg :bg palette.bg})
(custom-set-face! :Pmenu [] {:fg palette.base04 :bg palette.base01})
(custom-set-face! :PmenuSbar [] {:fg palette.base04 :bg palette.base01})
(custom-set-face! :PmenuSel [] {:fg palette.blue :bg palette.base02})
(custom-set-face! :PmenuThumb [] {:fg palette.blue :bg palette.base02})
(custom-set-face! :SpecialKey [] {:fg palette.fg :bg palette.none})
(custom-set-face! :Visual [] {:fg palette.none :bg palette.base02})
(custom-set-face! :VisualNOS [] {:fg palette.none :bg palette.base02})
(custom-set-face! :TooLong [] {:fg palette.none :bg palette.base02})
(custom-set-face! :Debug [] {:fg palette.green :bg palette.none})
(custom-set-face! :Macro [:italic] {:fg palette.yellow :bg palette.none})
(custom-set-face! :MatchParen [:underline]
                  {:fg palette.none :bg palette.base02})

(custom-set-face! :Bold [:bold] {:fg palette.none :bg palette.none})
(custom-set-face! :Italic [:italic] {:fg palette.none :bg palette.none})
(custom-set-face! :Underlined [:underline] {:fg palette.none :bg palette.none})

;; diagnostics

(custom-set-face! :DiagnosticWarn [] {:fg palette.yellow :bg palette.none})
(custom-set-face! :DiagnosticError [] {:fg palette.red :bg palette.none})
(custom-set-face! :DiagnosticInfo [] {:fg palette.cyan :bg palette.none})
(custom-set-face! :DiagnosticHint [] {:fg palette.blue :bg palette.none})
(custom-set-face! :DiagnosticUnderlineWarn [:underline]
                  {:fg palette.base1 :bg palette.none})

(custom-set-face! :DiagnosticUnderlineError [:underline]
                  {:fg palette.red :bg palette.none})

(custom-set-face! :DiagnosticUnderlineInfo [:underline]
                  {:fg palette.cyan :bg palette.none})

(custom-set-face! :DiagnosticUnderlineHint [:underline]
                  {:fg palette.blue :bg palette.none})

;; health
(custom-set-face! :HealthError [] {:fg palette.red :bg palette.none})
(custom-set-face! :HealthWarning [] {:fg palette.yellow :bg palette.none})
(custom-set-face! :HealthSuccess [] {:fg palette.green :bg palette.none})

;; ledger

(custom-set-face! "@comment" [] {:link :Comment})
(custom-set-face! "@text.literal.commodity" []
                  {:fg palette.green :bg palette.none})

(custom-set-face! "@number" [] {:fg palette.pink :bg palette.none})
(custom-set-face! "@number.date" [] {:fg palette.pink :bg palette.none})
(custom-set-face! "@number.date.effective" []
                  {:fg palette.pink :bg palette.none})

(custom-set-face! "@number.interval" [] {:fg palette.pink :bg palette.none})

(custom-set-face! "@number.status" [] {:fg palette.pink :bg palette.none})
(custom-set-face! "@number.quantity" [] {:fg palette.pink :bg palette.none})

(custom-set-face! "@number.quantity.negative" []
                  {:fg palette.pink :bg palette.none})

;; lsp

(custom-set-face! :LspCodeLens [] {:fg palette.none :bg palette.base01})
(custom-set-face! :LspReferenceText [] {:fg palette.none :bg palette.base01})

(custom-set-face! :LspReferenceread [] {:fg palette.none :bg palette.base01})

(custom-set-face! :LspReferenceWrite [] {:fg palette.none :bg palette.base01})

(custom-set-face! :LspSignatureActiveParameter []
                  {:fg palette.magenta :bg palette.none})

;; lps-semantic-tokens
(custom-set-face! "@lsp.type.class" [:italic] {:fg palette.cyan :bg palette.none})
(custom-set-face! "@lsp.type.decorator" [] {:link :Decorator})
(custom-set-face! "@lsp.type.decorator.markdown" [] {:link :Structure})
(custom-set-face! "@lsp.type.function" [] {:link "@function"})
(custom-set-face! "@lsp.type.macro" [] {:link :Macro})
(custom-set-face! "@lsp.type.method" [] {:link "@function"})
(custom-set-face! "@lsp.type.struct" [:italic]
                  {:fg palette.cyan :bg palette.none})
(custom-set-face! "@lsp.type.type" [] {:link :Type})
(custom-set-face! "@lsp.type.typeParameter" [] {:link :Typedef})
(custom-set-face! "@lsp.type.selfParameter" [] {:link "@variable.builtin"})
(custom-set-face! "@lsp.type.builtinConstant" [] {:link "@constant.builtin"})
(custom-set-face! "@lsp.type.magicFunction" [] {:link "@function.builtin"})
(custom-set-face! "@lsp.type.boolean" [] {:link "@boolean"})
(custom-set-face! "@lsp.type.builtinType" [] {:link "@type.builtin"})
(custom-set-face! "@lsp.type.comment" [] {:link "@comment"})
(custom-set-face! "@lsp.type.enum" [:italic] {:link :Type})
(custom-set-face! "@lsp.type.enumMember" [] {:link "@constant"})
(custom-set-face! "@lsp.type.escapeSequence" [] {:link "@string.escape"})
(custom-set-face! "@lsp.type.formatSpecifier" [] {:link "@punctuation.special"})
;;(custom-set-face! "@lsp.type.interface" [] {})
(custom-set-face! "@lsp.type.keyword" [] {:link "@keyword"})
(custom-set-face! "@lsp.type.namespace" [] {:link "@namespace"})
(custom-set-face! "@lsp.type.number" [] {:link "@number"})
(custom-set-face! "@lsp.type.operator" [] {:link "@operator"})
(custom-set-face! "@lsp.type.parameter" [] {:link "@parameter"})
(custom-set-face! "@lsp.type.property" [] {:link "@property"})
(custom-set-face! "@lsp.type.selfKeyword" [] {:link "@variable.builtin"})
(custom-set-face! "@lsp.type.string.rust" [] {:link "@string"})
(custom-set-face! "@lsp.type.typeAlias" [] {:link "@type.definition"})
(custom-set-face! "@lsp.type.unresolvedReference" [] {:link :Error})
(custom-set-face! "@lsp.type.variable" [] {:link "@variable"})
(custom-set-face! "@lsp.mod.readonly" [] {:link "@constant"})
(custom-set-face! "@lsp.mod.typeHint" [] {:link :Type})
(custom-set-face! "@lsp.mod.builtin" [] {:link :Special})
(custom-set-face! "@lsp.typemod.class.defaultLibrary" []
                  {:link "@type.builtin"})

(custom-set-face! "@lsp.typemod.enum.defaultLibrary" [] {:link "@type.builtin"})
(custom-set-face! "@lsp.typemod.enumMember.defaultLibrary" []
                  {:link "@constant.builtin"})

(custom-set-face! "@lsp.typemod.function.defaultLibrary" []
                  {:link "@function.builtin"})

(custom-set-face! "@lsp.typemod.keyword.async" [] {:link "@keyword.coroutine"})
(custom-set-face! "@lsp.typemod.macro.defaultLibrary" []
                  {:link "@function.builtin"})

(custom-set-face! "@lsp.typemod.method.defaultLibrary" []
                  {:link "@function.builtin"})

(custom-set-face! "@lsp.typemod.operator.injected" [] {:link "@operator"})
(custom-set-face! "@lsp.typemod.string.injected" [] {:link "@string"})
(custom-set-face! "@lsp.typemod.operator.controlFlow" [] {:link "@exception"})
(custom-set-face! "@lsp.typemod.keyword.documentation" [] {:link :Special})
(custom-set-face! "@lsp.typemod.variable.global" [] {:link "@constant"})
(custom-set-face! "@lsp.typemod.variable.static" [] {:link "@constant"})
(custom-set-face! "@lsp.typemod.variable.defaultLibrary" [] {:link :Special})
(custom-set-face! "@lsp.typemod.function.builtin" []
                  {:link "@function.builtin"})

(custom-set-face! "@lsp.typemod.function.readonly" [] {:link "@method"})
;;(custom-set-face! "@lsp.typemod.type.defaultLibrary" [] {})
(custom-set-face! "@lsp.typemod.variable.defaultLibrary" []
                  {:link "@variable.builtin"})

(custom-set-face! "@lsp.typemod.variable.injected" [] {:link "@variable"})

;; gutter

(custom-set-face! :Folded [] {:fg palette.base02 :bg palette.base01})
(custom-set-face! :FoldColumn [] {:fg palette.base01 :bg palette.bg})
(custom-set-face! :SignColumn [] {:fg palette.base01 :bg palette.bg})

;; navigation

(custom-set-face! :Directory [] {:fg palette.magenta :bg palette.none})

;; prompts

(custom-set-face! :EndOfBuffer [] {:fg palette.base01 :bg palette.none})
(custom-set-face! :ErrorMsg [] {:fg palette.yellow :bg palette.none})
(custom-set-face! :ModeMsg [] {:fg palette.base04 :bg palette.none})
(custom-set-face! :MoreMsg [] {:fg palette.magenta :bg palette.none})
(custom-set-face! :Question [] {:fg palette.base04 :bg palette.none})
(custom-set-face! :Substitute [] {:fg palette.base01 :bg palette.magenta})
(custom-set-face! :WarningMsg [] {:fg palette.orange :bg palette.none})
(custom-set-face! :WildMenu [] {:fg palette.magenta :bg palette.base01})

;; vimhelp

(custom-set-face! :helpHyperTextJump [] {:fg palette.magenta :bg palette.none})

(custom-set-face! :helpSpecial [] {:fg palette.red :bg palette.none})
(custom-set-face! :helpHeadline [] {:fg palette.yellow :bg palette.none})
(custom-set-face! :helpHeader [] {:fg palette.pink :bg palette.none})

;; diff

(custom-set-face! :DiffAdded [] {:fg palette.green :bg palette.none})
(custom-set-face! :DiffChanged [] {:fg palette.yellow :bg palette.none})
(custom-set-face! :DiffRemoved [] {:fg palette.red :bg palette.none})
(custom-set-face! :DiffAdd [] {:bg palette.green :fg palette.bg})
(custom-set-face! :DiffChange [] {:bg palette.yellow :fg palette.bg})
(custom-set-face! :DiffText [] {:bg palette.blue :fg palette.bg})
(custom-set-face! :DiffDelete [] {:bg palette.red :fg palette.bg})

;; search

(custom-set-face! :IncSearch [] {:fg palette.base06 :bg palette.yellow})
(custom-set-face! :Search [] {:fg palette.base01 :bg palette.magenta})

;; tabs

(custom-set-face! :TabLine [] {:link :StatusLineNC})
(custom-set-face! :TabLineFill [] {:link :TabLine})
(custom-set-face! :TabLineSel [] {:link :StatusLine})

;; window

(custom-set-face! :Title [:bold] {:fg palette.green :bg palette.none})
;; VertSplit has been replaced by `WinSpeperator` in nvim 0.10
(custom-set-face! :VertSplit [] {:fg palette.base01 :bg palette.bg})
(custom-set-face! :WinSeparator [] {:fg palette.base01 :bg palette.bg})

;; regular syntax

(custom-set-face! :Boolean [:italic] {:fg palette.magenta :bg palette.none})
(custom-set-face! :Character [] {:fg palette.magenta :bg palette.none})
(custom-set-face! :Comment [:italic] {:fg palette.base05 :bg palette.none})

(custom-set-face! :Conceal [] {:fg palette.none :bg palette.none})
(custom-set-face! :Conditional [] {:fg palette.red :bg palette.none})
(custom-set-face! :Constant [] {:fg palette.fg :bg palette.none})
(custom-set-face! :Decorator [] {:fg palette.yellow :bg palette.none})
(custom-set-face! :Define [] {:fg palette.red :bg palette.none})
(custom-set-face! :Delimeter [] {:fg palette.base06 :bg palette.none})
(custom-set-face! :Exception [] {:fg palette.orange :bg palette.none})
(custom-set-face! :Float [] {:link :Number})
(custom-set-face! :Function [] {:fg palette.green :bg palette.none})
(custom-set-face! :Identifier [] {:fg palette.base04 :bg palette.none})
(custom-set-face! :Include [] {:fg palette.red :bg palette.none})
(custom-set-face! :Keyword [] {:fg palette.red :bg palette.none})
(custom-set-face! :Label [] {:fg palette.red :bg palette.none})
(custom-set-face! :Number [] {:fg palette.magenta :bg palette.none})
(custom-set-face! :Operator [:bold] {:fg palette.orange :bg palette.none})
(custom-set-face! :PreProc [] {:fg palette.red :bg palette.none})
(custom-set-face! :Repeat [] {:fg palette.red :bg palette.none})
(custom-set-face! :Special [] {:fg palette.green :bg palette.none})
(custom-set-face! :SpecialChar [] {:fg palette.green :bg palette.none})
(custom-set-face! :SpecialComment [] {:fg palette.green :bg palette.none})
(custom-set-face! :Statement [] {:fg palette.red :bg palette.none})
(custom-set-face! :StorageClass [] {:fg palette.red :bg palette.none})
(custom-set-face! :String [] {:fg palette.blue :bg palette.none})
(custom-set-face! :Structure [] {:fg palette.cyan :bg palette.none})
(custom-set-face! :Tag [] {:fg palette.base04 :bg palette.none})
(custom-set-face! :Todo [] {:fg palette.green :bg palette.none})
(custom-set-face! :Type [] {:fg palette.cyan :bg palette.none})
(custom-set-face! :Typedef [] {:fg palette.purple :bg palette.none})

;; markdown

(custom-set-face! :markdownBlockquote [] {:fg palette.magenta :bg palette.none})

(custom-set-face! :markdownBold [] {:link :Bold})
(custom-set-face! :markdownItalic [] {:link :Italic})
(custom-set-face! :markdownBoldItalic [:bold :italic]
                  {:fg palette.none :bg palette.none})

(custom-set-face! :markdownRule [] {:link :Comment})
(custom-set-face! :markdownH1 [] {:fg palette.blue :bg palette.none})
(custom-set-face! :markdownH2 [] {:link :markdownH1})
(custom-set-face! :markdownH3 [] {:link :markdownH1})
(custom-set-face! :markdownH4 [] {:link :markdownH1})
(custom-set-face! :markdownH5 [] {:link :markdownH1})
(custom-set-face! :markdownH6 [] {:link :markdownH1})
(custom-set-face! :markdownHeadingDelimiter [] {:link :markdownH1})
(custom-set-face! :markdownHeadingRule [] {:link :markdownH1})
(custom-set-face! :markdownUrl [:underline]
                  {:fg palette.orange :bg palette.none})

(custom-set-face! :markdownCode [] {:link :String})
(custom-set-face! :markdownCodeBlock [] {:link :markdownCode})
(custom-set-face! :markdownCodeDelimiter [] {:link :markdownCode})
(custom-set-face! :markdownUrl [] {:link :String})
(custom-set-face! :markdownListMarker [] {:fg palette.magenta :bg palette.none})

(custom-set-face! :markdownOrderedListMarker []
                  {:fg palette.magenta :bg palette.none})

; markdown treesitter
(custom-set-face! "@markup" [] {:link "@none"})
(custom-set-face! "@markup.environment" [] {:link :Macro})
(custom-set-face! "@markup.environment.name" [] {:link :Type})
(custom-set-face! "@markup.emphasis" [] {:italic true})
(custom-set-face! "@markup.italic" [] {:italic true})
(custom-set-face! "@markup.strikethrough" [] {:strikethrough true})
(custom-set-face! "@markup.strong" [] {:bold true})
(custom-set-face! "@markup.underline" [] {:underline true})

(custom-set-face! "@markup.heading" [] {:link :Title})
(custom-set-face! "@markup.heading.marker" [] {:link :markdownHeadingDelimiter})
(custom-set-face! "@markup.heading.1.markdown" [] {:link :markdownH1})
(custom-set-face! "@markup.heading.2.markdown" [] {:link :markdownH1})
(custom-set-face! "@markup.heading.3.markdown" [] {:link :markdownH1})
(custom-set-face! "@markup.heading.4.markdown" [] {:link :markdownH1})
(custom-set-face! "@markup.heading.5.markdown" [] {:link :markdownH1})
(custom-set-face! "@markup.heading.6.markdown" [] {:link :markdownH1})
(custom-set-face! "@markup.heading.7.markdown" [] {:link :markdownH1})
(custom-set-face! "@markup.heading.8.markdown" [] {:link :markdownH1})

(custom-set-face! "@markup.link" [] {:link :markdownUrl})
(custom-set-face! "@markup.link.label" [] {:underline true})
(custom-set-face! "@markup.link.label.symbol" [] {:link :markdownItalic})
(custom-set-face! "@markup.link.label.markdown_inline" []
                  {:link :markdownItalic})

(custom-set-face! "@markup.link.title" [] {:link :Title})
(custom-set-face! "@markup.link.url" [] {:link :markdownUrl})
(custom-set-face! "@markup.link.destination" [] {:link :markdownUrl})
(custom-set-face! "@markup.link.description" []
                  {:fg palette.blend :underline true :italic true})

(custom-set-face! "@markup.list" [] {:link :markdownListMarker})
(custom-set-face! "@markup.list.bullet" [] {:link :markdownListMarker})
(custom-set-face! "@markup.list.checked" [] {:link :markdownListMarker})
(custom-set-face! "@markup.list.markdown" [] {:link :markdownListMarker})
(custom-set-face! "@markup.list.ordered" [] {:link :markdownOrderedListMarker})
(custom-set-face! "@markup.list.unchecked" [] {:link :markdownListMarker})

(custom-set-face! "@markup.math" [] {:link :Special})
(custom-set-face! "@markup.raw" [] {:link :String})
(custom-set-face! "@markup.raw.markdown_inline" [] {:link :String})
(custom-set-face! "@markup.quote" [] {:link :markdownBlockquote})

(custom-set-face! "@markup.literal" [] {:link :markdownCode})
(custom-set-face! "@markup.code.block" [] {:link :markdownCodeBlock})
(custom-set-face! "@markup.rule" [] {:link :Comment})

;; asciidoc

(custom-set-face! :asciidocAttributeEntry []
                  {:fg palette.pink :bg palette.none})

(custom-set-face! :asciidocAttributeList [] {:link :asciidocAttributeEntry})
(custom-set-face! :asciidocAttributeRef [] {:link :asciidocAttributeEntry})
(custom-set-face! :asciidocHLabel [] {:link :markdownH1})
(custom-set-face! :asciidocOneLineTitle [] {:link :markdownH1})
(custom-set-face! :asciidocQuotedMonospaced [] {:link :markdownBlockquote})
(custom-set-face! :asciidocURL [] {:link :markdownUrl})

;; treesitter
;;; misc

(custom-set-face! "@comment" [] {:link :Comment})
(custom-set-face! "@error" [] {:fg palette.blue :bg palette.none})

;; @none
;; @preproc
;; @define

(custom-set-face! "@operator" [] {:link :Operator})

;;; punctuation

(custom-set-face! "@punctuation.delimiter" []
                  {:fg palette.base06 :bg palette.none})

(custom-set-face! "@punctuation.bracket" []
                  {:fg palette.base06 :bg palette.none})

(custom-set-face! "@punctuation.special" []
                  {:fg palette.green :bg palette.none})

;;; literals

(custom-set-face! "@string" [] {:link :String})
(custom-set-face! "@string.regex" [] {:fg palette.green :bg palette.none})
(custom-set-face! "@string.escape" [] {:fg palette.green :bg palette.none})

;; @string.special

(custom-set-face! "@character" [] {:link :Character})

;; @character.special

(custom-set-face! "@boolean" [] {:link :Boolean})
(custom-set-face! "@number" [] {:link :Number})
(custom-set-face! "@float" [] {:link :Float})

;;; functions

(custom-set-face! "@function" [] {:fg palette.yellow :bg palette.none})

(custom-set-face! "@function.builtin" [:italic]
                  {:fg palette.yellow :bg palette.none})

;; @function.call

(custom-set-face! "@function.macro" [] {:fg palette.yellow :bg palette.none})

(custom-set-face! "@method" [] {:fg palette.cyan :bg palette.none})

;; @method.call

(custom-set-face! "@constructor" [] {:fg palette.red :bg palette.none})
(custom-set-face! "@parameter" [:bold] {:fg palette.fg :bg palette.none})

;;; keywords

(custom-set-face! "@keyword" [] {:fg palette.red :bg palette.none})
(custom-set-face! "@keyword.function" []
                  {:fg palette.red :bg palette.none})

(custom-set-face! "@keyword.operator" [:italic]
                  {:fg palette.orange :bg palette.none})

;; @keyword.return

(custom-set-face! "@conditional" [] {:fg palette.red :bg palette.none})
(custom-set-face! "@repeat" [] {:fg palette.red :bg palette.none})

;; @debug

(custom-set-face! "@label" [] {:fg palette.pink :bg palette.none})
(custom-set-face! "@include" [] {:fg palette.red :bg palette.none})
(custom-set-face! "@exception" [] {:fg palette.orange :bg palette.none})

;;; types

(custom-set-face! "@type" [] {:link :Type})
(custom-set-face! "@type.builtin" [] {:link :Type})

;; @type.defintion
;; @type.qualifier
;; @storageclass
;; @storageclass.lifetime

(custom-set-face! "@attribute" [] {:fg palette.fg :bg palette.none})
(custom-set-face! "@field" [] {:fg palette.fg :bg palette.none})
(custom-set-face! "@property" [] {:fg palette.fg :bg palette.none})

;;; identifiers

(custom-set-face! "@variable" [] {:fg palette.fg :bg palette.none})
(custom-set-face! "@variable.builtin" [:italic] {:fg palette.fg :bg palette.none})

(custom-set-face! "@constant" [] {:fg palette.fg :bg palette.none})
(custom-set-face! "@constant.builtin" [:italic]
                  {:fg palette.fg :bg palette.none})

(custom-set-face! "@constant.macro" [] {:fg palette.cyan :bg palette.none})

(custom-set-face! "@namespace" [] {:fg palette.fg :bg palette.none})
(custom-set-face! "@symbol" [:bold] {:fg palette.pink :bg palette.none})

;;; text

(custom-set-face! "@text" [] {:fg palette.base04 :bg palette.none})
(custom-set-face! "@text.strong" [] {:fg palette.none :bg palette.none})
(custom-set-face! "@text.emphasis" [:bold]
                  {:fg palette.yellow :bg palette.none})

(custom-set-face! "@text.underline" [:underline]
                  {:fg palette.yellow :bg palette.none})

(custom-set-face! "@text.strike" [:strikethrough]
                  {:fg palette.yellow :bg palette.none})

(custom-set-face! "@text.title" [] {:fg palette.yellow :bg palette.none})
(custom-set-face! "@text.literal" [] {:fg palette.base04 :bg palette.none})
(custom-set-face! "@text.uri" [:underline]
                  {:fg palette.orange :bg palette.none})

;; @text.math
;; @text.environment
;; @text.environment.name
;; @text.reference
;; @text.todo
;; @text.note
;; @text.warning
;; @text.danger
;; @text.diff.add
;; @text.diff.delete
;;; tags

(custom-set-face! "@tag" [] {:fg palette.red :bg palette.none})
(custom-set-face! "@tag.attribute" [] {:fg palette.pink :bg palette.none})
(custom-set-face! "@tag.delimiter" [] {:fg palette.pink :bg palette.none})
(custom-set-face! "@tag.builtin.tsx" [] {:link "@tag.tsx"})

;;; Conceal
;; @conceal
;;; Spell
(custom-set-face! "@spell.markdown" [] {:fg palette.fg :bg palette.none})
;; @nospell
;;; non-standard
;; @variable.global
;;; locals
;; @definition
;; @definition.constant
;; @definition.function
;; @definition.method
;; @definition.var
;; @definition.parameter
;; @definition.macro
;; @definition.type
;; @definition.field
;; @definition.enum
;; @definition.namespace
;; @definition.import
;; @definition.associated
;; @scope

(custom-set-face! "@reference" [] {:fg palette.base04 :bg palette.none})

;; neovim

(custom-set-face! :NvimInternalError [] {:fg palette.bg :bg palette.magenta})

(custom-set-face! :NormalFloat [] {:fg palette.base05 :bg palette.blend})
(custom-set-face! :FloatBorder [] {:fg palette.blend :bg palette.blend})
(custom-set-face! :NormalNC [] {:fg palette.base04 :bg palette.bg})
(custom-set-face! :TermCursor [] {:fg palette.bg :bg palette.base04})
(custom-set-face! :TermCursorNC [] {:fg palette.bg :bg palette.base04})

;; statusline/winbar

(custom-set-face! :StatusLine [] {:fg palette.base04 :bg palette.bg})
(custom-set-face! :StatusLineNC [] {:fg palette.base04 :bg palette.base01})
(custom-set-face! :StatusReplace [] {:fg palette.bg :bg palette.magenta})
(custom-set-face! :StatusInsert [] {:fg palette.bg :bg palette.purple})
(custom-set-face! :StatusVisual [] {:fg palette.bg :bg palette.orange})
(custom-set-face! :StatusTerminal [] {:fg palette.bg :bg palette.blue})

(custom-set-face! :StatusNormal [] {:fg palette.bg :bg palette.pink})
(custom-set-face! :StatusCommand [] {:fg palette.bg :bg palette.green})
(custom-set-face! :StatusLineDiagnosticWarn [:bold]
                  {:fg palette.yellow :bg palette.bg})

(custom-set-face! :StatusLineDiagnosticError [:bold]
                  {:fg palette.red :bg palette.bg})

;; telescope

(custom-set-face! :TelescopeBorder [] {:fg palette.blend :bg palette.blend})
(custom-set-face! :TelescopePromptBorder []
                  {:fg palette.base02 :bg palette.base02})

(custom-set-face! :TelescopePromptNormal []
                  {:fg palette.base05 :bg palette.base02})

(custom-set-face! :TelescopePromptPrefix []
                  {:fg palette.magenta :bg palette.base02})

(custom-set-face! :TelescopeNormal [] {:fg palette.none :bg palette.blend})
(custom-set-face! :TelescopePreviewTitle []
                  {:fg palette.base02 :bg palette.purple})

(custom-set-face! :TelescopePromptTitle []
                  {:fg palette.base02 :bg palette.blue})

(custom-set-face! :TelescopeResultsTitle []
                  {:fg palette.blend :bg palette.blend})

(custom-set-face! :TelescopeSelection [] {:fg palette.none :bg palette.base02})

(custom-set-face! :TelescopePreviewLine []
                  {:fg palette.none :bg palette.base01})

(custom-set-face! :TelescopeMatching [:bold :italic]
                  {:fg palette.magenta :bg palette.none})

;; notify

(custom-set-face! :NotifyERRORBorder [] {:fg palette.magenta :bg palette.none})

(custom-set-face! :NotifyWARNBorder [] {:fg palette.orange :bg palette.none})

(custom-set-face! :NotifyINFOBorder [] {:fg palette.base05 :bg palette.none})

(custom-set-face! :NotifyDEBUGBorder [] {:fg palette.green :bg palette.none})

(custom-set-face! :NotifyTRACEBorder [] {:fg palette.green :bg palette.none})

(custom-set-face! :NotifyERRORIcon [] {:fg palette.magenta :bg palette.none})
(custom-set-face! :NotifyWARNIcon [] {:fg palette.orange :bg palette.none})
(custom-set-face! :NotifyINFOIcon [] {:fg palette.base05 :bg palette.none})
(custom-set-face! :NotifyDEBUGIcon [] {:fg palette.green :bg palette.none})
(custom-set-face! :NotifyTRACEIcon [] {:fg palette.green :bg palette.none})
(custom-set-face! :NotifyERRORTitle [] {:fg palette.magenta :bg palette.none})

(custom-set-face! :NotifyWARNTitle [] {:fg palette.orange :bg palette.none})
(custom-set-face! :NotifyINFOTitle [] {:fg palette.base05 :bg palette.none})
(custom-set-face! :NotifyDEBUGTitle [] {:fg palette.green :bg palette.none})

(custom-set-face! :NotifyTRACETitle [] {:fg palette.green :bg palette.none})

;; cmp

(custom-set-face! :CmpItemAbbr [] {:fg "#adadad" :bg palette.none})
(custom-set-face! :CmpItemAbbrMatch [:bold] {:fg palette.red :bg palette.none})

(custom-set-face! :CmpItemAbbrMatchFuzzy [:bold]
                  {:fg palette.base04 :bg palette.none})

(custom-set-face! :CmpItemMenu [:italic] {:fg palette.base04 :bg palette.none})

(custom-set-face! :CmpItemKindInterface []
                  {:fg palette.base01 :bg palette.magenta})

(custom-set-face! :CmpItemKindColor [] {:fg palette.base01 :bg palette.magenta})

(custom-set-face! :CmpItemKindTypeParameter []
                  {:fg palette.base01 :bg palette.magenta})

(custom-set-face! :CmpItemKindText [] {:fg palette.base01 :bg palette.red})

(custom-set-face! :CmpItemKindEnum [] {:fg palette.base01 :bg palette.red})

(custom-set-face! :CmpItemKindKeyword [] {:fg palette.base01 :bg palette.red})

(custom-set-face! :CmpItemKindConstant []
                  {:fg palette.base01 :bg palette.yellow})

(custom-set-face! :CmpItemKindConstructor []
                  {:fg palette.base01 :bg palette.yellow})

(custom-set-face! :CmpItemKindReference []
                  {:fg palette.base01 :bg palette.yellow})

(custom-set-face! :CmpItemKindFunction [] {:fg palette.base01 :bg palette.blue})

(custom-set-face! :CmpItemKindStruct [] {:fg palette.base01 :bg palette.blue})

(custom-set-face! :CmpItemKindClass [] {:fg palette.base01 :bg palette.blue})

(custom-set-face! :CmpItemKindModule [] {:fg palette.base01 :bg palette.blue})

(custom-set-face! :CmpItemKindOperator [] {:fg palette.base01 :bg palette.blue})

(custom-set-face! :CmpItemKindField [] {:fg palette.base01 :bg palette.purple})

(custom-set-face! :CmpItemKindProperty []
                  {:fg palette.base01 :bg palette.purple})

(custom-set-face! :CmpItemKindEvent [] {:fg palette.base01 :bg palette.purple})

(custom-set-face! :CmpItemKindUnit [] {:fg palette.base01 :bg palette.green})

(custom-set-face! :CmpItemKindSnippet [] {:fg palette.base01 :bg palette.green})

(custom-set-face! :CmpItemKindFolder [] {:fg palette.base01 :bg palette.green})

(custom-set-face! :CmpItemKindVariable []
                  {:fg palette.base01 :bg palette.orange})

(custom-set-face! :CmpItemKindFile [] {:fg palette.base01 :bg palette.orange})

(custom-set-face! :CmpItemKindMethod [] {:fg palette.base01 :bg palette.pink})

(custom-set-face! :CmpItemKindValue [] {:fg palette.base01 :bg palette.pink})

(custom-set-face! :CmpItemKindEnumMember []
                  {:fg palette.base01 :bg palette.pink})

;; nvimtree

(custom-set-face! :NvimTreeImageFile [] {:fg palette.purple :bg palette.none})

(custom-set-face! :NvimTreeFolderIcon [] {:fg palette.purple :bg palette.none})

(custom-set-face! :NvimTreeWinSeparator [] {:fg palette.bg :bg palette.base00})

(custom-set-face! :NvimTreeFolderName [] {:fg palette.red :bg palette.none})

(custom-set-face! :NvimTreeIndentMarker []
                  {:fg palette.base02 :bg palette.none})

(custom-set-face! :NvimTreeEmptyFolderName []
                  {:fg palette.pink :bg palette.none})

(custom-set-face! :NvimTreeOpenedFolderName []
                  {:fg palette.pink :bg palette.none})

(custom-set-face! :NvimTreeNormal [] {:fg palette.base04 :bg palette.bg})

;; neogit

(custom-set-face! :NeogitBranch [] {:fg palette.yellow :bg palette.none})
(custom-set-face! :NeogitRemote [] {:fg palette.red :bg palette.none})
(custom-set-face! :NeogitHunkHeader [] {:fg palette.base04 :bg palette.base02})

(custom-set-face! :NeogitHunkHeaderHighlight []
                  {:fg palette.base04 :bg palette.fg})

;; gitsigns
(custom-set-face! :GitSignsCurrentLineBlame [] {:link :Comment})

;; hydra

(custom-set-face! :HydraRed [] {:fg palette.purple :bg palette.none})
(custom-set-face! :HydraBlue [] {:fg palette.red :bg palette.none})
(custom-set-face! :HydraAmaranth [] {:fg palette.yellow :bg palette.none})
(custom-set-face! :HydraTeal [] {:fg palette.magenta :bg palette.none})
(custom-set-face! :HydraHint [] {:fg palette.none :bg palette.blend})

;; alpha

(custom-set-face! :alpha1 [] {:fg palette.fg :bg palette.none})
(custom-set-face! :alpha2 [] {:fg palette.base04 :bg palette.none})
(custom-set-face! :alpha3 [] {:fg palette.fg :bg palette.none})

;; headlines.nvim

(custom-set-face! :CodeBlock [] {:fg palette.none :bg palette.base01})

;; nvim-bufferline

(custom-set-face! :BufferLineDiagnostic [:bold]
                  {:fg palette.yellow :bg palette.none})

(custom-set-face! :BufferLineDiagnosticVisible [:bold]
                  {:fg palette.yellow :bg palette.none})

;; preservim/vim-markdown

(custom-set-face! :htmlH1 [] {:link :markdownH1})
(custom-set-face! :mkdRule [] {:link :markdownRule})
(custom-set-face! :mkdListItem [] {:link :markdownListMarker})
(custom-set-face! :mkdListItemCheckbox [] {:link :markdownListMarker})

;; vimwiki/vimwiki

(custom-set-face! :VimwikiHeader1 [] {:link :markdownH1})
(custom-set-face! :VimwikiHeader2 [] {:link :markdownH1})
(custom-set-face! :VimwikiHeader3 [] {:link :markdownH1})
(custom-set-face! :VimwikiHeader4 [] {:link :markdownH1})
(custom-set-face! :VimwikiHeader5 [] {:link :markdownH1})
(custom-set-face! :VimwikiHeader6 [] {:link :markdownH1})
(custom-set-face! :VimwikiHeaderChar [] {:link :markdownH1})
(custom-set-face! :VimwikiList [] {:link :markdownListMarker})
(custom-set-face! :VimwikiLink [] {:link :markdownUrl})
(custom-set-face! :VimwikiCode [] {:link :markdownCode})

;; flash

(custom-set-face! :FlashLabel [:bold] {:fg palette.magenta :bg palette.bg})

;; Orgmode
(custom-set-face! "@org.keyword.todo" [] {:fg palette.red :bg palette.bg})
(custom-set-face! "@org.keyword.todo" [] {:fg palette.red :bg palette.bg})
(custom-set-face! "@org.headline.level2" [] {:fg palette.red :bg palette.bg})


{: palette}
