cd('/media/lukas/goliath/projects/FEED/fLoc')
addpath(genpath(pwd));
STIM_DIR = '../stims/stim_selection'
stim_set = 3;
num_subs = 30;
num_runs = 4;
task_num = 1;
fLoc = fLocSequence(stim_set, num_runs, task_num);

for i = [1:30, 96, 97, 98, 99]
    sub_name = ['sub-' num2str(i, '%02.f')];
    seq = fLoc.make_runs();
    fname = [sub_name '_task-localizer_stims.tsv'];
    disp(['Processing ' fname]);
    fileID = fopen([STIM_DIR '/' sub_name '/' fname], 'w');
    fprintf(fileID, '%s\t%s\t%s\t%s\n', 'session', 'stim_name', 'predef_stim_onset', 'task_probe');

    for ii = 1:num_runs
        
        for iii = 1:size(seq.stim_onsets, 1)
            fprintf(fileID, '%i\t', ii); 
            fprintf(fileID, '%s\t', char(seq.stim_names(iii, ii)));
            fprintf(fileID, '%.3f\t', seq.stim_onsets(iii, ii));
            fprintf(fileID, '%i\n', seq.task_probes(iii, ii));
        end
    end
    fclose(fileID);
end
