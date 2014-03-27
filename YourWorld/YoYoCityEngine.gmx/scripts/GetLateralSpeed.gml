
normalDirection = GetWorldDirection(0);
normalX = lengthdir_x(1, normalDirection);
normalY = lengthdir_y(1, normalDirection);

var dot = dot_product(normalX, normalY, phy_speed_x, phy_speed_y);
lateralX = normalX * dot;
lateralY = normalY * dot;

return dot_product(phy_speed_x, phy_speed_y, normalX, normalY);

