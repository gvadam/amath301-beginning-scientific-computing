function [t,y] = forward_euler(odefun,tspan,y0)
    tspan = reshape(tspan,[length(tspan) 1]);    
    y0 = reshape(y0,[length(y0) 1]);    
    dt = tspan(2)-tspan(1);    
    y = zeros(length(y0),length(tspan));    
    y(:,1) = y0;    
    for k = 1:length(y)-1        
           y(:,k+1) = y(:,k) + dt*odefun(tspan(k),y(:,k));    
    end
    t = tspan;    
    y = y.';
end