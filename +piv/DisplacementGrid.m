% DisplacementGrid
% PIV package
% Author: Francesco Mascadri
% Contact: fmascadri@student.unimelb.edu.au
% April 2022

classdef DisplacementGrid < handle

    properties
        dpx
        dpy
    end

    methods
        %Removing spurious vectors and helper functions
        function removeSpuriousVectors(obj)
            dpxOutlierIndices = findOutliersX(obj);
            dpyOutlierIndices = findOutliersY(obj);

            % Removes all obvious outliers in the first pass
            replaceOutliersX(obj, dpxOutlierIndices);
            replaceOutliersY(obj, dpyOutlierIndices);

            % Runs outlier search again to find more fine-grained outliers
            dpxOutlierIndices = findOutliersX(obj);
            dpyOutlierIndices = findOutliersY(obj);

            replaceOutliersX(obj, dpxOutlierIndices);
            replaceOutliersY(obj, dpyOutlierIndices);
        end

        function outlierIndices = findOutliersX(obj)
            meanDisplacement = mean(mean(obj.dpx));
            stdDisplacement = mean(std(obj.dpx));
            outlierIndicesHigh = find(obj.dpx>=meanDisplacement + 3*stdDisplacement);
            outlierIndicesLow = find(obj.dpx<=meanDisplacement - 3*stdDisplacement);
            outlierIndices = [outlierIndicesLow; outlierIndicesHigh];
        end
        function outlierIndices = findOutliersY(obj)
            meanDisplacement = mean(mean(obj.dpy));
            stdDisplacement = mean(std(obj.dpy));
            outlierIndicesHigh = find(obj.dpy>=meanDisplacement + 3*stdDisplacement);
            outlierIndicesLow = find(obj.dpy<=meanDisplacement - 3*stdDisplacement);
            outlierIndices = [outlierIndicesLow; outlierIndicesHigh];
        end

        function replaceOutliersX(obj, dpxOutlierIndices)
            obj.dpx(dpxOutlierIndices) = NaN;
            dpmean = mean(obj.dpx, [1 2], 'omitnan');
            obj.dpx(dpxOutlierIndices) = dpmean;
        end
        function replaceOutliersY(obj, dpyOutlierIndices)
            obj.dpy(dpyOutlierIndices) = NaN;
            dpmean = mean(obj.dpy, [1 2], 'omitnan');
            obj.dpy(dpyOutlierIndices) = dpmean;
        end


        %Plotting functions
        function plotField(obj, xgrid, ygrid, titlestr, axislimits)
            quiver(xgrid, ygrid, obj.dpx, obj.dpy);
            xlabel("x-distance (pixels)");
            ylabel("y-distance (pixels)");
            title(titlestr);
            axis(axislimits);
            daspect([1 1 1]);
        end
        function plotXContour(obj,xgrid,ygrid,titlestr, axislimits)
            surf(xgrid, ygrid, obj.dpx);
            view(2);
            xlabel("x-distance (pixels)");
            ylabel("y-distance (pixels)");
            title(titlestr);
            axis(axislimits);
            daspect([1 1 1]);
            colorbar;
        end
        function plotYContour(obj,xgrid,ygrid,titlestr, axislimits)
            surf(xgrid, ygrid, obj.dpy);
            view(2);
            xlabel("x-distance (pixels)");
            ylabel("y-distance (pixels)");
            title(titlestr);
            axis(axislimits);
            daspect([1 1 1]);
            colorbar;
        end
    end
    
end