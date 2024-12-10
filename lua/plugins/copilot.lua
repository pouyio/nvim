local f = require("plugins.common.utils")
return {
	"github/copilot.vim",
	enabled = f.isMac(),
}
