local M = {
	'kyazdani42/nvim-web-devicons',
	module = 'nvim-web-devicons',
}

function M.config()
	local has_devicons, devicons = pcall(require, 'nvim-web-devicons')
	if not has_devicons then return end

	local utils = require('jgoguen.utils')
	devicons.set_default_icon(utils.get_icon('DefaultFile'), '#6d8086', '66')
	devicons.set_icon({
		deb = {icon = utils.get_icon('DEB'), name = 'DEB'},
		lock = {icon = utils.get_icon('Lock'), name = 'Lock'},
		mp3 = {icon = utils.get_icon('MP3'), name = 'MP3'},
		mp4 = {icon = utils.get_icon('MP4'), name = 'MP4'},
		out = {icon = utils.get_icon('Pararaph'), name = 'Out'},
		['robots.txt'] = {icon = utils.get_icon('Robot'), name = 'Robots'},
		otf = {icon = utils.get_icon('Font'), name = 'OpenTypeFont'},
		ttf = {icon = utils.get_icon('Font'), name = 'TrueTypeFont'},
		rpm = {icon = utils.get_icon('RPM'), name = 'RPM'},
		woff = {icon = utils.get_icon('Font'), name = 'WebOpenFontFormat'},
		woff2 = {icon = utils.get_icon('Font'), name = 'WebOpenFontFormat2'},
		xz = {icon = utils.get_icon('ArchiveFile'), name = 'XZ'},
		zip = {icon = utils.get_icon('ArchiveFile'), name = 'ZIP'},
	})
end

return M
