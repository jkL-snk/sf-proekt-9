[worker]
%{ for ip in worker ~}
${ip}
%{ endfor ~}
