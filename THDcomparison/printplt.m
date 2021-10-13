%% Copyright (C) 2014 Martin Šíra
%%

function printplt(filename)
        
        % % find if running on supercomputer 'cokl', if so, set output terminal to x11:
        % iscokl=1;
        % if iscokl
                % terminal = "postscript";
        % else
                % terminal = "wxt";
        % endif
        if isOctave
            % print plot to plt:
            drawnow ('postscript', "/dev/null", [filename '.plt'])
        else
            saveas(gcf, [filename '.png']);
        end

end

% vim settings modeline: vim: foldmarker=%<<<,%>>> fdm=marker fen ft=matlab textwidth=1000
