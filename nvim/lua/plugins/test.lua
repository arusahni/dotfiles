return {
    'janko-m/vim-test',
    cmd = {
        "TestNearest",
        "TestFile",
        "TestSuite",
        "TestLast",
        "TestVisit",
    },
    config = function()
        vim.cmd([[let test#strategy = "neoterm"]])
    end
}
