if exists("did_load_filetypes")
  finish
endif
"+ augroup filetypedetect
"+ " system_verilog files
"+   au BufNewFile,BufRead *.sv	setf systemverilog
"+ augroup END

augroup filetypedetect
au BufNewFile,BufRead *.v,*.vh,*.sv      setf verilog_systemverilog
augroup END
