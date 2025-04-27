-- Cyrillic langmap
vim.opt.langmap = "йq,цw,уe,кr,еt,нy,гu,шi,щo,зp,фa,ыs,іs,вd,аf,пg,рh,оj,лk,дl,яz,чx,сc,мv,иb,тn,ьm," ..
    "ЙQ,ЦW,УE,КR,ЕT,НY,ГU,ШI,ЩO,ЗP,ФA,ЫS,ІS,ВD,АF,ПG,РH,ОJ,ЛK,ДL,ЯZ,ЧX,СC,МV,ИB,ТN,ЬM," ..
    "ё`,Ё~,ʼ~,э',є',х[,ъ],ї],Х{,Ъ},Ї},Б<,Ю>,Ж:,Ґ|,Э\",Є\",ю."

vim.keymap.set('n', 'б', ',', { noremap = true })
vim.keymap.set('n', 'ж', ';', { noremap = true })

-- NOTE: these work in vanilla vim by default, by not in neovim for some reason
vim.keymap.set('i', '<C-х>', '<C-[>', { noremap = true })
vim.keymap.set('i', '<C-с>', '<C-C>', { noremap = true })
vim.keymap.set('i', '<C-ц>', '<C-w>', { noremap = true })
vim.keymap.set('i', '<C-ф>', '<C-a>', { noremap = true })
vim.keymap.set('i', '<C-р>', '<C-H>', { noremap = true })
vim.keymap.set('i', '<C-г>', '<C-u>', { noremap = true })
vim.keymap.set('i', '<C-ш>', '<C-i>', { noremap = true })
vim.keymap.set('i', '<C-о>', '<C-j>', { noremap = true })
vim.keymap.set('i', '<C-ь>', '<C-m>', { noremap = true })
vim.keymap.set('i', '<C-л>', '<C-k>', { noremap = true })
vim.keymap.set('i', '<C-т>', '<C-n>', { noremap = true })
vim.keymap.set('i', '<C-з>', '<C-p>', { noremap = true })
vim.keymap.set('i', '<C-к>', '<C-r>', { noremap = true })
vim.keymap.set('i', '<C-ы>', '<C-s>', { noremap = true })
vim.keymap.set('i', '<C-і>', '<C-s>', { noremap = true })
vim.keymap.set('i', '<C-е>', '<C-t>', { noremap = true })
vim.keymap.set('i', '<C-в>', '<C-d>', { noremap = true })
vim.keymap.set('i', '<C-м>', '<C-v>', { noremap = true })
vim.keymap.set('i', '<C-й>', '<C-q>', { noremap = true })
vim.keymap.set('i', '<C-S-м>', '<C-S-v>', { noremap = true })
vim.keymap.set('i', '<C-S-й>', '<C-S-q>', { noremap = true })
vim.keymap.set('i', '<C-ч>', '<C-x>', { noremap = true })
vim.keymap.set('i', '<C-у>', '<C-e>', { noremap = true })
vim.keymap.set('i', '<C-н>', '<C-y>', { noremap = true })
vim.keymap.set('i', '<C-ъ>', '<C-]>', { noremap = true })
vim.keymap.set('i', '<C-ї>', '<C-]>', { noremap = true })
vim.keymap.set('i', '<C-и>', '<C-b>', { noremap = true })
vim.keymap.set('i', '<C-а>', '<C-f>', { noremap = true })
vim.keymap.set('i', '<C-п>', '<C-g>', { noremap = true })
vim.keymap.set('i', '<C-д>', '<C-l>', { noremap = true })
vim.keymap.set('i', '<C-щ>', '<C-o>', { noremap = true })

-- Jump centering
vim.keymap.set("n", "<C-d>", "<C-d>zz0")
vim.keymap.set("n", "<C-u>", "<C-u>zz0")

-- Diagnostic keymaps
vim.diagnostic.config({ virtual_text = true })

vim.keymap.set("n", "[d", function() return vim.diagnostic.jump({ count = 1, float = true }) end,
    { desc = "Go to previous [D]iagnostic message" })
vim.keymap.set("n", "]d", function() return vim.diagnostic.jump({ count = -1, float = true }) end,
    { desc = "Go to next [D]iagnostic message" })
vim.keymap.set("n", "<leader>e", vim.diagnostic.open_float, { desc = "Show diagnostic [E]rror messages" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic [Q]uickfix list" })

-- Exit the terminal
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Open the terminal in a new window
vim.cmd.cnoreabbrev("vterm", "vs|term")
vim.cmd.cnoreabbrev("sterm", "sp|term")

-- Insert newline without leaving normal mode
vim.keymap.set("n", "<Leader>o", "o<Esc>", { desc = "Insert line below" })
vim.keymap.set("n", "<Leader>O", "O<Esc>", { desc = "Insert line above" })

vim.cmd.cnoreabbrev("cfg", "e " .. vim.fn.stdpath("config"))
