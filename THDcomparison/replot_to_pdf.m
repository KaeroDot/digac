## Function copies plot and changes terminal postscript to pdf

function replot_to_pdf(fnpart, unescape_bash=0)
        % function called from bash so remove escaping characters is needed?
        if unescape_bash
                fnpart = strrep(fnpart, '\(', '(', "overlaps", 0);
                fnpart = strrep(fnpart, '\)', ')', "overlaps", 0);
                fnpart = strrep(fnpart, '\ ', ' ', "overlaps", 0);
        endif
        % remove plt extension if present:
        if strcmpi(fnpart(end-3:end),'.plt')
                fnpart = fnpart(1:end-4);
        endif
        % generate filenames:
        orfn = [fnpart '.plt'];
        nefn = [fnpart '-pdf.plt'];
        [DIR, NAME, EXT] = fileparts (nefn);
        nefnname = [NAME '.plt'];
        nefnpdf = [NAME '.pdf'];
        if not(exist(orfn, 'file'))
                error(['filename `' orfn '` does not exist'])
        endif

        % copy file
        copyfile(orfn, nefn);

        % load plt file
        fid = fopen(nefn,"r");
        [pltstr,count] = fread(fid, [1,inf], 'uint8=>char');  % s will be a character array, count has the number of bytes
        fclose(fid);

        % change terminal to pdfcairo
        pltstr = regexprep(pltstr, 'set terminal .* dashlength (\d)', 'set terminal pdfcairo enhanced size 11.2,8.4 dashlength $1 fontscale 1.2');
        % change output file to .pdf
        pltstr = regexprep(pltstr, 'set output .*', ['set output ' char(39) nefnpdf char(39) ';'], 'dotexceptnewline');
        % thicken line widths
        pltstr = regexprep(pltstr, 'set style line (.*) linewidth \d', ['set style line $1 linewidth 5'], 'dotexceptnewline');

        % save new plt file
        fid = fopen (nefn, "w");
        fprintf(fid, "%s", pltstr);
        fclose(fid);

        % call gnuplot to generate pdf
        msg = ['cd ' DIR '; gnuplot "' nefnname '"']
        system(msg);
% 
end

% vim modeline: vim: foldmarker=%<<<,%>>> fdm=marker fen ft=matlab textwidth=1000
