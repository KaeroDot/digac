## Function changes gnuplot terminal from postscript to wxt in all .plt files in selected directory

function plot_change_gnuplot_terminal(directory)

        %msg = ['ls "' directory filesep() '"*.plt | xargs sed -i ' char(39) 's/terminal postscript.* dashlength/terminal wxt enhanced size 560,420 dashlength/g' char(39)]
        msg = ['find "' directory '" -name "*.plt" -print0 | xargs -0 sed -i ' char(39) 's/terminal postscript.* dashlength/terminal wxt enhanced size 560,420 dashlength/g' char(39)]
        system(msg);

endfunction

% vim modeline: vim: foldmarker=%<<<,%>>> fdm=marker fen ft=octave textwidth=1000
