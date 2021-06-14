[jenkins]
%{ for ip in jenkins ~}
${ip}
%{ endfor ~}

[workers]
%{ for ip in workers1 ~}
${ip}
%{ endfor ~}
%{ for ip in workers2 ~}
${ip}
%{ endfor ~}