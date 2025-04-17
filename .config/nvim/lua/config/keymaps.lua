-- Cyrillic langmap
vim.opt.langmap = "йq,цw,уe,кr,еt,нy,гu,шi,щo,зp,фa,ыs,іs,вd,аf,пg,рh,оj,лk,дl,яz,чx,сc,мv,иb,тn,ьm," ..
    "ЙQ,ЦW,УE,КR,ЕT,НY,ГU,ШI,ЩO,ЗP,ФA,ЫS,ІS,ВD,АF,ПG,РH,ОJ,ЛK,ДL,ЯZ,ЧX,СC,МV,ИB,ТN,ЬM," ..
    "ё`,Ё~,ʼ~,э',є',х[,ъ],ї],Х{,Ъ},Ї},Б<,Ю>,Ж:,Ґ|,Э\",Є\",ю."

vim.keymap.set('n', 'б', ',', { noremap = true })
vim.keymap.set('n', 'ж', ';', { noremap = true })

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
