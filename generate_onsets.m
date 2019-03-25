cd('/media/lukas/goliath/projects/FEED/fLoc')
addpath(genpath(pwd));
STIM_DIR = '../stims/stim_selection'
stim_set = 3;
num_subs = 50;
num_runs = 4;
task_num = 1;
fLoc = fLocSequence(stim_set, num_runs, task_num);
%fLoc = fLocSequence_with_scrambled(stim_set, num_runs, task_num);

for i = [1:num_subs]
    sub_name = ['sub-' num2str(i, '%02.f')];
    seq = fLoc.make_runs();
    fname = [sub_name '_task-localizer_stims.tsv'];
    disp(['Processing ' fname]);
    %fileID = fopen([STIM_DIR '/' sub_name '/' fname], 'w');
    fileID = fopen(fname, 'w');
    fprintf(fileID, '%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\t%s\n', 'sub_id', 'onset', 'duration', 'trial_type', ...
            'isi', 'trial_nr', 'run', 'stim_name', 'task_probe');

    for ii = 1:num_runs
        
        for iii = 1:size(seq.stim_onsets, 1)
            tmp = strsplit(char(seq.stim_names(iii, ii)), '-');
            trial_type = tmp{1};
            fprintf(fileID, '%s\t', sub_name);
            fprintf(fileID, '%.3f\t', seq.stim_onsets(iii, ii));
            fprintf(fileID, '%.3f\t', 0.4);
            fprintf(fileID, '%s\t', trial_type);
            fprintf(fileID, '%.3f\t', 0.1);
            fprintf(fileID, '%i\t', iii-1);
            fprintf(fileID, '%i\t', ii);
            fprintf(fileID, '%s\t', char(seq.stim_names(iii, ii)));
            fprintf(fileID, '%i\n', seq.task_probes(iii, ii));
        end
    end
    fclose(fileID);
end
