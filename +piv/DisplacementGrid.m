classdef DisplacementGrid < handle

    properties
        dpx
        dpy
    end

    methods
        function plot(obj)
            x = linspace(1,100);
            y = rand(1,100);
            plot(x,y)
        end
    end
    
end