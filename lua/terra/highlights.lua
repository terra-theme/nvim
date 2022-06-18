local c = require("terra.colors")
local cfg = vim.g.terra_config
local util = require("terra.util")

local M = {}

local hl = { langs = {}, plugins = {} }

-- TODO: Declare highlights type
local function vim_highlights(highlights)
	for group_name, group_settings in pairs(highlights) do
		vim.api.nvim_command(
			string.format(
				"highlight %s guifg=%s guibg=%s guisp=%s gui=%s",
				group_name,
				group_settings.fg or "none",
				group_settings.bg or "none",
				group_settings.sp or "none",
				group_settings.fmt or "none"
			)
		)
	end
end

-- QUESTION: Why redfine ?
-- TODO: Resolve if possible
local colors = {
	Fg = { fg = c.fg },
	LightGrey = { fg = c.light_grey },
	Grey = { fg = c.grey },
	Red = { fg = c.red },
	Cyan = { fg = c.dark_cyan },
	Yellow = { fg = c.yellow },
	Orange = { fg = c.orange },
	Green = { fg = c.green },
	Blue = { fg = c.blue },
	Purple = { fg = c.purple },
}

hl.common = {
	Normal = { fg = c.fg, bg = cfg.transparent and c.none or c.bg1 },
	Terminal = { fg = c.fg, bg = cfg.transparent and c.none or c.bg1 },
	EndOfBuffer = { fg = cfg.ending_tildes and c.bg2 or c.bg1, bg = cfg.transparent and c.none or c.bg1 },
	FoldColumn = { fg = c.grey, bg = cfg.transparent and c.none or c.bg1 },
	Folded = { fg = c.grey, bg = cfg.transparent and c.none or c.bg1 },
	SignColumn = { fg = c.fg, bg = cfg.transparent and c.none or c.bg1 },
	ToolbarLine = { fg = c.fg },
	Cursor = { fmt = "reverse" },
	vCursor = { fmt = "reverse" },
	iCursor = { fmt = "reverse" },
	lCursor = { fmt = "reverse" },
	CursorIM = { fmt = "reverse" },
	CursorColumn = { bg = c.bg1 },
	CursorLine = { bg = c.bg1 },
	ColorColumn = { bg = c.bg1 },
	CursorLineNr = { fg = c.yellow },
	LineNr = { fg = c.grey },
	Conceal = { fg = c.grey, bg = c.bg1 },
	DiffAdd = { fg = c.none, bg = c.diff_add },
	DiffChange = { fg = c.none, bg = c.diff_change },
	DiffDelete = { fg = c.none, bg = c.diff_delete },
	DiffText = { fg = c.none, bg = c.diff_text },
	DiffAdded = colors.Green,
	DiffRemoved = colors.Red,
	DiffFile = colors.Cyan,
	DiffIndexLine = colors.Grey,
	Directory = { fg = c.blue },
	ErrorMsg = { fg = c.red, fmt = "bold" },
	WarningMsg = { fg = c.yellow, fmt = "bold" },
	MoreMsg = { fg = c.blue, fmt = "bold" },
	IncSearch = { fg = c.bg0, bg = c.dark_cyan},
	Search = { fg = c.bg0, bg = c.dark_cyan },
	Substitute = { fg = c.bg0, bg = c.green },
	MatchParen = { fg = c.none, bg = c.grey },
	NonText = { fg = c.grey },
	Whitespace = { fg = c.grey },
	SpecialKey = { fg = c.grey },
	Pmenu = { fg = c.fg, bg = c.bg1 },
	PmenuSbar = { fg = c.none, bg = c.bg1 },
	PmenuSel = { fg = c.bg0, bg = c.bg_blue },
	WildMenu = { fg = c.bg0, bg = c.blue },
	PmenuThumb = { fg = c.none, bg = c.grey },
	Question = { fg = c.yellow },
	SpellBad = { fg = c.red, fmt = "underline", sp = c.red },
	SpellCap = { fg = c.yellow, fmt = "underline", sp = c.yellow },
	SpellLocal = { fg = c.blue, fmt = "underline", sp = c.blue },
	SpellRare = { fg = c.purple, fmt = "underline", sp = c.purple },
	StatusLine = { fg = c.fg, bg = c.bg2 },
	StatusLineTerm = { fg = c.fg, bg = c.bg2 },
	StatusLineNC = { fg = c.grey, bg = c.bg1 },
	StatusLineTermNC = { fg = c.grey, bg = c.bg1 },
	TabLine = { fg = c.fg, bg = c.bg1 },
	TabLineFill = { fg = c.grey, bg = c.bg1 },
	TabLineSel = { fg = c.fg, bg = c.bg3 },
	VertSplit = { fg = c.grey },
	Visual = { bg = c.bg3 },
	VisualNOS = { fg = c.none, bg = c.bg2, fmt = "underline" },
	QuickFixLine = { fg = c.blue, fmt = "underline" },
	Debug = { fg = c.yellow },
	debugPC = { fg = c.bg0, bg = c.green },
	debugBreakpoint = { fg = c.bg0, bg = c.red },
	ToolbarButton = { fg = c.bg0, bg = c.bg_blue },
	FloatBorder = { fg = c.grey, bg = c.bg1 },
	NormalFloat = { fg = c.fg, bg = c.bg1 },
}

hl.css = {
	cssPositioningAttr = { fg = c.blue },
	cssBoxAttr = { fg = c.blue },
	cssTextAttr = { fg = c.blue },
	cssCommonAttr = { fg = c.blue },
	cssCascadeAttr = { fg = c.blue },
	cssFlexibleBoxAttr = { fg = c.blue },
	cssUnitDecorators = { fg = c.yellow },
	cssValueLength = { fg = c.dark_blue },
}

hl.sass = {
	sassVariable = { fg = c.dark_yellow },
	sassMixing = { fg = c.dark_red },
	sassCssAttribute = { fg = c.white },
}

hl.syntax = {
	String = { fg = c.green, fmt = cfg.code_style.strings },
	Character = colors.Orange,
	Number = colors.Orange,
	Float = colors.Orange,
	Boolean = colors.Orange,
	Type = colors.Yellow,
	Structure = colors.Yellow,
	StorageClass = colors.Yellow,
	Identifier = { fg = c.red, fmt = cfg.code_style.variables },
	Constant = colors.Cyan,
	PreProc = colors.Purple,
	PreCondit = colors.Purple,
	Include = colors.Purple,
	Keyword = { fg = c.purple, fmt = cfg.code_style.keywords },
	Define = colors.Purple,
	Typedef = colors.Purple,
	Exception = colors.Purple,
	Conditional = { fg = c.purple, fmt = cfg.code_style.keywords },
	Repeat = { fg = c.purple, fmt = cfg.code_style.keywords },
	Statement = colors.Purple,
	Macro = colors.Red,
	Error = colors.Purple,
	Label = colors.Purple,
	Special = colors.Red,
	SpecialChar = colors.Red,
	Function = { fg = c.blue, fmt = cfg.code_style.functions },
	Operator = colors.Purple,
	Title = colors.Cyan,
	Tag = colors.Green,
	Delimiter = colors.LightGrey,
	Comment = { fg = c.grey, fmt = cfg.code_style.comments },
	SpecialComment = { fg = c.grey, fmt = cfg.code_style.comments },
	Todo = { fg = c.red, fmt = cfg.code_style.comments },
}

hl.treesitter = {
	TSAnnotation = colors.Fg,
	TSAttribute = colors.Cyan,
	TSBoolean = colors.Orange,
	TSCharacter = colors.Orange,
	TSComment = { fg = c.grey, fmt = cfg.code_style.comments },
	TSConditional = { fg = c.purple, fmt = cfg.code_style.keywords },
	TSConstant = colors.Orange,
	TSConstBuiltin = colors.Orange,
	TSConstMacro = colors.Orange,
	TSConstructor = { fg = c.yellow, fmt = "bold" },
	TSError = colors.Fg,
	TSException = colors.Purple,
	TSField = colors.Cyan,
	TSFloat = colors.Orange,
	TSFunction = { fg = c.yellow, fmt = cfg.code_style.functions },
	TSFuncBuiltin = { fg = c.cyan, fmt = cfg.code_style.functions },
	TSFuncMacro = { fg = c.cyan, fmt = cfg.code_style.functions },
	TSInclude = colors.Purple,
	TSKeyword = { fg = c.red, fmt = cfg.code_style.keywords },
	TSKeywordFunction = { fg = c.purple, fmt = cfg.code_style.functions },
	TSKeywordOperator = { fg = c.purple, fmt = cfg.code_style.keywords },
	TSLabel = { fg = c.dark_yellow },
	TSMethod = colors.Blue,
	TSNamespace = colors.Yellow,
	TSNone = colors.Fg,
	TSNumber = colors.Orange,
	TSOperator = { fg = c.white },
	TSParameter = { fg = c.dark_yellow },
	TSParameterReference = colors.Fg,
	TSProperty = { fg = c.blue },
	TSPunctDelimiter = { fg = c.white },
	TSPunctBracket = { fg = c.white },
	TSPunctSpecial = colors.Red,
	TSRepeat = { fg = c.purple, fmt = cfg.code_style.keywords },
	TSString = { fg = c.cyan, fmt = cfg.code_style.strings },
	TSStringRegex = { fg = c.orange, fmt = cfg.code_style.strings },
	TSStringEscape = { fg = c.red, fmt = cfg.code_style.strings },
	TSSymbol = colors.Cyan,
	TSTag = { fg = c.yellow },
	TSTagDelimiter = { fg = c.dark_yellow },
	TSText = colors.Fg,
	TSStrong = { fg = c.fg, fmt = "bold" },
	TSEmphasis = { fg = c.fg, fmt = "italic" },
	TSUnderline = { fg = c.fg, fmt = "underline" },
	TSStrike = { fg = c.fg, fmt = "strikethrough" },
	TSTitle = { fg = c.orange, fmt = "bold" },
	TSLiteral = colors.Green,
	TSURI = { fg = c.cyan, fmt = "underline" },
	TSMath = colors.Fg,
	TSTextReference = colors.Blue,
	TSEnviroment = colors.Fg,
	TSEnviromentName = colors.Fg,
	TSNote = colors.Fg,
	TSWarning = colors.Fg,
	TSDanger = colors.Fg,
	TSType = { fg = c.yellow },
	TSTypeBuiltin = { fg = c.yellow },
	TSVariable = { fg = c.dark_yellow, fmt = cfg.code_style.variables },
	TSVariableBuiltin = { fg = c.red, fmt = cfg.code_style.variables },
}

local diagnostics_error_color = cfg.diagnostics.darker and c.dark_red or c.red
local diagnostics_hint_color = cfg.diagnostics.darker and c.dark_blue or c.blue
local diagnostics_warn_color = cfg.diagnostics.darker and c.dark_yellow or c.yellow
local diagnostics_info_color = cfg.diagnostics.darker and c.dark_cyan or c.cyan

hl.plugins.lsp = {
	LspCxxHlGroupEnumConstant = colors.Orange,
	LspCxxHlGroupMemberVariable = colors.Orange,
	LspCxxHlGroupNamespace = colors.Blue,
	LspCxxHlSkippedRegion = colors.Grey,
	LspCxxHlSkippedRegionBeginEnd = colors.Red,

	DiagnosticError = { fg = c.red },
	DiagnosticHint = { fg = c.blue },
	DiagnosticInfo = { fg = c.cyan },
	DiagnosticWarn = { fg = c.yellow },

	DiagnosticVirtualTextError = {
		bg = cfg.diagnostics.background and util.darken(diagnostics_error_color, 0.1, c.bg1) or c.none,
		fg = diagnostics_error_color,
	},
	DiagnosticVirtualTextWarn = {
		bg = cfg.diagnostics.background and util.darken(diagnostics_warn_color, 0.1, c.bg1) or c.none,
		fg = diagnostics_warn_color,
	},
	DiagnosticVirtualTextInfo = {
		bg = cfg.diagnostics.background and util.darken(diagnostics_info_color, 0.1, c.bg1) or c.none,
		fg = diagnostics_info_color,
	},
	DiagnosticVirtualTextHint = {
		bg = cfg.diagnostics.background and util.darken(diagnostics_hint_color, 0.1, c.bg1) or c.none,
		fg = diagnostics_hint_color,
	},

	DiagnosticUnderlineError = { fmt = cfg.diagnostics.undercurl and "undercurl" or "underline", sp = c.red },
	DiagnosticUnderlineHint = { fmt = cfg.diagnostics.undercurl and "undercurl" or "underline", sp = c.blue },
	DiagnosticUnderlineInfo = { fmt = cfg.diagnostics.undercurl and "undercurl" or "underline", sp = c.blue },
	DiagnosticUnderlineWarn = { fmt = cfg.diagnostics.undercurl and "undercurl" or "underline", sp = c.yellow },

	LspReferenceText = { bg = c.bg2 },
	LspReferenceWrite = { bg = c.bg2 },
	LspReferenceRead = { bg = c.bg2 },

	LspCodeLens = { fg = c.grey, fmt = cfg.code_style.comments },
	LspCodeLensSeparator = { fg = c.grey },
}

hl.plugins.lsp.LspDiagnosticsDefaultError = hl.plugins.lsp.DiagnosticError
hl.plugins.lsp.LspDiagnosticsDefaultHint = hl.plugins.lsp.DiagnosticHint
hl.plugins.lsp.LspDiagnosticsDefaultInformation = hl.plugins.lsp.DiagnosticInfo
hl.plugins.lsp.LspDiagnosticsDefaultWarning = hl.plugins.lsp.DiagnosticWarn
hl.plugins.lsp.LspDiagnosticsUnderlineError = hl.plugins.lsp.DiagnosticUnderlineError
hl.plugins.lsp.LspDiagnosticsUnderlineHint = hl.plugins.lsp.DiagnosticUnderlineHint
hl.plugins.lsp.LspDiagnosticsUnderlineInformation = hl.plugins.lsp.DiagnosticUnderlineInfo
hl.plugins.lsp.LspDiagnosticsUnderlineWarning = hl.plugins.lsp.DiagnosticUnderlineWarn
hl.plugins.lsp.LspDiagnosticsVirtualTextError = hl.plugins.lsp.DiagnosticVirtualTextError
hl.plugins.lsp.LspDiagnosticsVirtualTextWarning = hl.plugins.lsp.DiagnosticVirtualTextWarn
hl.plugins.lsp.LspDiagnosticsVirtualTextInformation = hl.plugins.lsp.DiagnosticVirtualTextInfo
hl.plugins.lsp.LspDiagnosticsVirtualTextHint = hl.plugins.lsp.DiagnosticVirtualTextHint

hl.plugins.ale = {
	ALEErrorSign = hl.plugins.lsp.DiagnosticError,
	ALEInfoSign = hl.plugins.lsp.DiagnosticInfo,
	ALEWarningSign = hl.plugins.lsp.DiagnosticWarn,
}

hl.plugins.barbar = {
	BufferCurrent = { fmt = "bold" },
	BufferCurrentMod = { fg = c.orange, bg = c.bg1, fmt = "bold,italic" },
	BufferCurrentSign = { fg = c.yellow },
	BufferInactiveMod = { fg = c.light_grey, bg = c.bg2, fmt = "italic" },
	BufferVisible = { fg = c.light_grey, bg = c.bg1 },
	BufferVisibleMod = { fg = c.yellow, bg = c.bg1, fmt = "italic" },
	BufferVisibleIndex = { fg = c.light_grey, bg = c.bg1 },
	BufferVisibleSign = { fg = c.light_grey, bg = c.bg1 },
	BufferVisibleTarget = { fg = c.light_grey, bg = c.bg1 },
}

hl.plugins.cmp = {
	CmpItemAbbr = colors.Fg,
	CmpItemAbbrDeprecated = { fg = c.light_grey, fmt = "strikethrough" },
	CmpItemAbbrMatch = colors.Cyan,
	CmpItemAbbrMatchFuzzy = { fg = c.cyan, fmt = "underline" },
	CmpItemMenu = colors.LightGrey,
	CmpItemKind = { fg = c.purple, fmt = cfg.cmp_itemkind_reverse and "reverse" },
}

hl.plugins.coc = {
	CocErrorSign = hl.plugins.lsp.DiagnosticError,
	CocHintSign = hl.plugins.lsp.DiagnosticHint,
	CocInfoSign = hl.plugins.lsp.DiagnosticInfo,
	CocWarningSign = hl.plugins.lsp.DiagnosticWarn,
}

hl.plugins.whichkey = {
	WhichKey = colors.Red,
	WhichKeyDesc = colors.Blue,
	WhichKeyGroup = colors.Orange,
	WhichKeySeperator = colors.Green,
}

-- TODO: Solvable with a Link to ToggleTermNormal?
hl.plugins.toggleterm = {
	ToggleTerm1FloatBorder = { fg = c.grey },
	ToggleTerm1NormalFloat = { fg = c.fg, bg = c.bg1 },
	ToggleTerm2FloatBorder = { fg = c.grey },
	ToggleTerm2NormalFloat = { fg = c.fg, bg = c.bg1 },
	ToggleTerm3FloatBorder = { fg = c.grey },
	ToggleTerm3NormalFloat = { fg = c.fg, bg = c.bg1 },
	ToggleTerm4FloatBorder = { fg = c.grey },
	ToggleTerm4NormalFloat = { fg = c.fg, bg = c.bg1 },
	ToggleTerm5FloatBorder = { fg = c.grey },
	ToggleTerm5NormalFloat = { fg = c.fg, bg = c.bg1 },
	ToggleTerm6FloatBorder = { fg = c.grey },
	ToggleTerm6NormalFloat = { fg = c.fg, bg = c.bg1 },
	ToggleTerm7FloatBorder = { fg = c.grey },
	ToggleTerm7NormalFloat = { fg = c.fg, bg = c.bg1 },
	ToggleTerm8FloatBorder = { fg = c.grey },
	ToggleTerm8NormalFloat = { fg = c.fg, bg = c.bg1 },
	ToggleTerm9FloatBorder = { fg = c.grey },
	ToggleTerm9NormalFloat = { fg = c.fg, bg = c.bg1 },
}

hl.plugins.gitgutter = {
	GitGutterAdd = { fg = c.green },
	GitGutterChange = { fg = c.blue },
	GitGutterDelete = { fg = c.red },
}

hl.plugins.hop = {
	HopNextKey = { fg = c.red, fmt = "bold" },
	HopNextKey1 = { fg = c.cyan, fmt = "bold" },
	HopNextKey2 = { fg = util.darken(c.blue, 0.7) },
	HopUnmatched = colors.Grey,
}

-- comment
hl.plugins.diffview = {
	DiffviewFilePanelTitle = { fg = c.blue, fmt = "bold" },
	DiffviewFilePanelCounter = { fg = c.purple, fmt = "bold" },
	DiffviewFilePanelFileName = colors.Fg,
	DiffviewNormal = hl.common.Normal,
	DiffviewCursorLine = hl.common.CursorLine,
	DiffviewVertSplit = hl.common.VertSplit,
	DiffviewSignColumn = hl.common.SignColumn,
	DiffviewStatusLine = hl.common.StatusLine,
	DiffviewStatusLineNC = hl.common.StatusLineNC,
	DiffviewEndOfBuffer = hl.common.EndOfBuffer,
	DiffviewFilePanelRootPath = colors.Grey,
	DiffviewFilePanelPath = colors.Grey,
	DiffviewFilePanelInsertions = colors.Green,
	DiffviewFilePanelDeletions = colors.Red,
	DiffviewStatusAdded = colors.Green,
	DiffviewStatusUntracked = colors.Blue,
	DiffviewStatusModified = colors.Blue,
	DiffviewStatusRenamed = colors.Blue,
	DiffviewStatusCopied = colors.Blue,
	DiffviewStatusTypeChange = colors.Blue,
	DiffviewStatusUnmerged = colors.Blue,
	DiffviewStatusUnknown = colors.Red,
	DiffviewStatusDeleted = colors.Red,
	DiffviewStatusBroken = colors.Red,
}

hl.plugins.gitsigns = {
	GitSignsAdd = colors.Green,
	GitSignsAddLn = colors.Green,
	GitSignsAddNr = colors.Green,
	GitSignsChange = colors.Blue,
	GitSignsChangeLn = colors.Blue,
	GitSignsChangeNr = colors.Blue,
	GitSignsDelete = colors.Red,
	GitSignsDeleteLn = colors.Red,
	GitSignsDeleteNr = colors.Red,
}

hl.plugins.nvim_tree = {
	NvimTreeNormal = { fg = c.fg, bg = cfg.transparent and c.none or c.bg0 },
	NvimTreeVertSplit = { fg = c.grey, bg = cfg.transparent and c.none or c.bg1 },
	NvimTreeEndOfBuffer = { fg = cfg.ending_tildes and c.bg2 or c.bg1, bg = cfg.transparent and c.none or c.bg0 },
	NvimTreeRootFolder = { fg = c.orange, fmt = "bold" },
	NvimTreeGitDirty = colors.Yellow,
	NvimTreeGitNew = colors.Green,
	NvimTreeGitDeleted = colors.Red,
	NvimTreeSpecialFile = { fg = c.yellow, fmt = "underline" },
	NvimTreeIndentMarker = colors.Fg,
	NvimTreeImageFile = { fg = c.dark_purple },
	NvimTreeSymlink = colors.Purple,
	NvimTreeFolderName = colors.Blue,
	NvimTreeCursorLine = { bg = c.bg1 },
	NvimTreeWindowPicker = { fg = c.white, bg = c.grey },
}

-- TODO: NeoTree Highlights
hl.plugins.neo_tree = {
	-- NeoTreeNormal = { fg = c.fg, bg = cfg.transparent and c.none or c.bg_d },
	-- NeoTreeNormalNC = { fg = c.fg, bg = cfg.transparent and c.none or c.bg_d },
}

hl.plugins.telescope = {
	TelescopeTitle = colors.Orange,
	TelescopeBorder = colors.Red,
	TelescopePromptBorder = colors.Grey,
	TelescopeResultsBorder = colors.Grey,
	TelescopePreviewBorder = colors.Grey,
	TelescopeMatching = { fg = c.orange, fmt = "bold" },
	TelescopePromptPrefix = colors.Green,
	TelescopeSelection = { bg = c.bg2 },
	TelescopeSelectionCaret = colors.Yellow,
}

hl.plugins.dashboard = {
	DashboardShortCut = colors.Blue,
	DashboardHeader = colors.Yellow,
	DashboardCenter = colors.Cyan,
	DashboardFooter = { fg = c.dark_red, fmt = "italic" },
}

hl.plugins.outline = {
	FocusedSymbol = { fg = c.purple, bg = c.bg2, fmt = "bold" },
	AerialLine = { fg = c.purple, bg = c.bg2, fmt = "bold" },
}

hl.plugins.ts_rainbow = {
	rainbowcol1 = colors.Grey,
	rainbowcol2 = colors.Yellow,
	rainbowcol3 = colors.Blue,
	rainbowcol4 = colors.Orange,
	rainbowcol5 = colors.Purple,
	rainbowcol6 = colors.Green,
	rainbowcol7 = colors.Red,
}

hl.plugins.incline = {
	InclineNormal = { bg = c.bg3 },
	InclineNormalNC = { bg = c.bg2 },
}

hl.langs.c = {
	cInclude = colors.Blue,
	cStorageClass = colors.Purple,
	cTypedef = colors.Purple,
	cDefine = colors.Cyan,
	cTSInclude = colors.Blue,
	cTSConstant = colors.Cyan,
	cTSConstMacro = colors.Purple,
	cTSOperator = colors.Purple,
}

hl.langs.cpp = {
	cppStatement = { fg = c.purple, fmt = "bold" },
	cppTSInclude = colors.Blue,
	cppTSConstant = colors.Cyan,
	cppTSConstMacro = colors.Purple,
	cppTSOperator = colors.Purple,
}

hl.langs.markdown = {
	markdownBlockquote = colors.Grey,
	markdownBold = { fg = c.none, fmt = "bold" },
	markdownBoldDelimiter = colors.Grey,
	markdownCode = colors.Green,
	markdownCodeBlock = colors.Green,
	markdownCodeDelimiter = colors.Yellow,
	markdownH1 = { fg = c.red, fmt = "bold" },
	markdownH2 = { fg = c.purple, fmt = "bold" },
	markdownH3 = { fg = c.orange, fmt = "bold" },
	markdownH4 = { fg = c.red, fmt = "bold" },
	markdownH5 = { fg = c.purple, fmt = "bold" },
	markdownH6 = { fg = c.orange, fmt = "bold" },
	markdownHeadingDelimiter = colors.Grey,
	markdownHeadingRule = colors.Grey,
	markdownId = colors.Yellow,
	markdownIdDeclaration = colors.Red,
	markdownItalic = { fg = c.none, fmt = "italic" },
	markdownItalicDelimiter = { fg = c.grey, fmt = "italic" },
	markdownLinkDelimiter = colors.Grey,
	markdownLinkText = colors.Red,
	markdownLinkTextDelimiter = colors.Grey,
	markdownListMarker = colors.Red,
	markdownOrderedListMarker = colors.Red,
	markdownRule = colors.Purple,
	markdownUrl = { fg = c.blue, fmt = "underline" },
	markdownUrlDelimiter = colors.Grey,
	markdownUrlTitleDelimiter = colors.Green,
}

hl.langs.php = {
	phpFunctions = { fg = c.fg, fmt = cfg.code_style.functions },
	phpMethods = colors.Cyan,
	phpStructure = colors.Purple,
	phpOperator = colors.Purple,
	phpMemberSelector = colors.Fg,
	phpVarSelector = { fg = c.orange, fmt = cfg.code_style.variables },
	phpIdentifier = { fg = c.orange, fmt = cfg.code_style.variables },
	phpBoolean = colors.Cyan,
	phpNumber = colors.Orange,
	phpHereDoc = colors.Green,
	phpNowDoc = colors.Green,
	phpSCKeyword = { fg = c.purple, fmt = cfg.code_style.keywords },
	phpFCKeyword = { fg = c.purple, fmt = cfg.code_style.keywords },
	phpRegion = colors.Blue,
}

hl.langs.scala = {
	scalaNameDefinition = colors.Fg,
	scalaInterpolationBoundary = colors.Purple,
	scalaInterpolation = colors.Purple,
	scalaTypeOperator = colors.Red,
	scalaOperator = colors.Red,
	scalaKeywordModifier = { fg = c.red, fmt = cfg.code_style.keywords },
}

hl.langs.tex = {
	latexTSInclude = colors.Blue,
	latexTSFuncMacro = { fg = c.fg, fmt = cfg.code_style.functions },
	latexTSEnvironment = { fg = c.cyan, fmt = "bold" },
	latexTSEnvironmentName = colors.Yellow,
	texCmdEnv = colors.Cyan,
	texEnvArgName = colors.Yellow,
	latexTSTitle = colors.Green,
	latexTSType = colors.Blue,
	latexTSMath = colors.Orange,
	texMathZoneX = colors.Orange,
	texMathZoneXX = colors.Orange,
	texMathDelimZone = colors.LightGrey,
	texMathDelim = colors.Purple,
	texMathOper = colors.Red,
	texCmd = colors.Purple,
	texCmdPart = colors.Blue,
	texCmdPackage = colors.Blue,
	texPgfType = colors.Yellow,
}

hl.langs.vim = {
	vimOption = colors.Red,
	vimSetEqual = colors.Yellow,
	vimMap = colors.Purple,
	vimMapModKey = colors.Orange,
	vimNotation = colors.Red,
	vimMapLhs = colors.Fg,
	vimMapRhs = colors.Blue,
	vimVar = { fg = c.fg, fmt = cfg.code_style.variables },
	vimCommentTitle = { fg = c.light_grey, fmt = cfg.code_style.comments },
}

local lsp_kind_icons_color = {
	Default = c.purple,
	Class = c.yellow,
	Color = c.green,
	Constant = c.orange,
	Constructor = c.blue,
	Enum = c.purple,
	EnumMember = c.yellow,
	Event = c.yellow,
	Field = c.purple,
	File = c.blue,
	Folder = c.orange,
	Function = c.blue,
	Interface = c.green,
	Keyword = c.cyan,
	Method = c.blue,
	Module = c.orange,
	Operator = c.red,
	Property = c.cyan,
	Reference = c.orange,
	Snippet = c.red,
	Struct = c.purple,
	Text = c.light_grey,
	TypeParameter = c.red,
	Unit = c.green,
	Value = c.orange,
	Variable = c.purple,
}

function M.setup()
	-- define cmp and aerial kind highlights with lsp_kind_icons_color
	for kind, color in pairs(lsp_kind_icons_color) do
		hl.plugins.cmp["CmpItemKind" .. kind] = { fg = color, fmt = cfg.cmp_itemkind_reverse and "reverse" }
		hl.plugins.outline["Aerial" .. kind .. "Icon"] = { fg = color }
	end

	vim_highlights(hl.common)
	vim_highlights(hl.syntax)
	vim_highlights(hl.css)
	vim_highlights(hl.sass)
	vim_highlights(hl.treesitter)
	for _, group in pairs(hl.langs) do
		vim_highlights(group)
	end
	for _, group in pairs(hl.plugins) do
		vim_highlights(group)
	end

	-- user defined highlights: vim_highlights function cannot be used because it sets an attribute to none if not specified
	local function replace_color(prefix, color_name)
		if not color_name then
			return ""
		end
		if color_name:sub(1, 1) == "$" then
			local name = color_name:sub(2, -1)
			color_name = c[name]
			if not color_name then
				vim.schedule(function()
					vim.notify(
						'terra.nvim: unknown color "' .. name .. '"',
						vim.log.levels.ERROR,
						{ title = "terra.nvim" }
					)
				end)
				return ""
			end
		end
		return prefix .. "=" .. color_name
	end

	for group_name, group_settings in pairs(vim.g.terra_config.highlights) do
		vim.api.nvim_command(
			string.format(
				"highlight %s %s %s %s %s",
				group_name,
				replace_color("guifg", group_settings.fg),
				replace_color("guibg", group_settings.bg),
				replace_color("guisp", group_settings.sp),
				replace_color("gui", group_settings.fmt)
			)
		)
	end
end

return M
