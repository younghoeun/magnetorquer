function raw = readData(fid)
    %% read data
    i = 1;
    line = 'start';
    while ischar(line)
        temp = str2num(line);
        if length(temp) == 14
            raw(i,:) = temp;       
            i = i+1;
        end        
        line = fgetl(fid);
    end
    fclose(fid);

    %% manual removal (spikes)
    magD = diff(raw(:,2:4));
    nmagD = vecnorm(magD');
    spikeIdx = abs(nmagD) > 5;
    raw(spikeIdx,:) = [];
end