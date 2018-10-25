stim_set = 3;
num_runs = 4;
task_num = 1;
fLoc = fLocSequence(stim_set, num_runs, task_num);
seq = fLoc.make_runs();

for i = 1:num_runs
   fname = sprintf('task-localizer_run-%i_stims.tsv', i);
   fileID = fopen(fname, 'w');
   fprintf(fileID, '%s\t%s\t%s\n', 'stim_name', 'stim_onset', 'task_probe');
   
   for ii = 1:size(seq.stim_onsets, 1)
       fprintf(fileID, '%s\t', char(seq.stim_names(ii, i)));
       fprintf(fileID, '%.3f\t', seq.stim_onsets(ii, i));
       fprintf(fileID, '%i\n', seq.task_probes(ii, i));
   end
   fclose(fileID);
   type(fname);
end
