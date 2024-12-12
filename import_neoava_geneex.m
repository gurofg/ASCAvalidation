%% NeoAva gene expression data
addpath(genpath('/mnt/work/RM_ASCA_LiMM_PCA_validation/New_analysis'));

data = importdata('Expression_data_NeoAva.txt');
textdata = data.textdata';
data = data.data';

datatable = array2table(data);
datatable.Properties.VariableNames = textdata(1,2:end);
datatable = [textdata(2:end,1), datatable];

clear textdata data ans
data = datatable; clear datatable

% Import sample info
opts = delimitedTextImportOptions("NumVariables", 28);
opts.DataLines = [2, Inf];
opts.Delimiter = "\t";
opts.VariableNames = ["SourceName", "Characteristicsorganism", "Characteristicsindividual", "Characteristicsdisease", "Characteristicstreatment", "Characteristicssamplingtimepoint", "Unittimeunit", "MaterialType", "ProtocolREF", "ProtocolREF1", "ExtractName", "ProtocolREF2", "LabeledExtractName", "Label", "ProtocolREF3", "AssayName", "TechnologyType", "ArrayDesignREF", "TermSourceREF", "ProtocolREF4", "ArrayDataFile", "CommentArrayExpressFTPfile", "ProtocolREF5", "DerivedArrayDataFile", "CommentDerivedArrayExpressFTPfile", "Factorvaluetreatment", "FactorValuesamplingtimepoint", "Unittimeunit1"];
opts.VariableTypes = ["string", "categorical", "double", "categorical", "categorical", "double", "categorical", "categorical", "double", "double", "string", "double", "string", "double", "double", "string", "categorical", "double", "categorical", "double", "string", "categorical", "double", "categorical", "categorical", "categorical", "double", "categorical"];
opts.ExtraColumnsRule = "ignore";
opts.EmptyLineRule = "read";
opts = setvaropts(opts, ["SourceName", "ExtractName", "LabeledExtractName", "AssayName", "ArrayDataFile"], "WhitespaceRule", "preserve");
opts = setvaropts(opts, ["SourceName", "Characteristicsorganism", "Characteristicsdisease", "Characteristicstreatment", "Unittimeunit", "MaterialType", "ExtractName", "LabeledExtractName", "AssayName", "TechnologyType", "TermSourceREF", "ArrayDataFile", "CommentArrayExpressFTPfile", "DerivedArrayDataFile", "CommentDerivedArrayExpressFTPfile", "Factorvaluetreatment", "Unittimeunit1"], "EmptyFieldRule", "auto");
opts = setvaropts(opts, ["ProtocolREF", "ProtocolREF1", "ProtocolREF2", "Label", "ProtocolREF3", "ArrayDesignREF", "ProtocolREF4", "ProtocolREF5"], "TrimNonNumeric", true);
opts = setvaropts(opts, ["ProtocolREF", "ProtocolREF1", "ProtocolREF2", "Label", "ProtocolREF3", "ArrayDesignREF", "ProtocolREF4", "ProtocolREF5"], "ThousandsSeparator", ",");
sampleinfo = readtable("/mnt/work/RM_ASCA+/NeoAva/Data/E-MTAB-4439.sdrf.txt", opts);
clear opts

data = sortrows(data, 'Var1');
sampleinfo = sortrows(sampleinfo, 'SourceName');
sampleinfo.SourceName = erase(sampleinfo.SourceName, ["NA12_", "NA25_", "NASC_"]);

sampleinfo.Properties.VariableNames(6) = "timepoint";
sampleinfo.Properties.VariableNames(5) = "treatment";
sampleinfo.Properties.VariableNames(1) = "ID";
data = [sampleinfo, data];

data.timepoint = nominal(data.timepoint);
data.treatment = nominal(data.treatment);

patients = unique(sampleinfo.ID);
patients_treatments = nominal();

for i = 1:size(patients,1)
    patients_treatments(i) = data.treatment(find(data.ID==patients(i), 1));
end

for i = 1:length(data.treatment)
    data.treatment(i) = patients_treatments(find(patients==intersect(data.ID(i), patients), 1));
end

data(find(data.treatment=="none"), :) = [];
patients(find(patients_treatments=="none")) = [];
patients_treatments(find(patients_treatments=="none")) = [];

clear i patients patients_treatments sampleinfo

data.Properties.VariableNames(1) = "ID";