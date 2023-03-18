output id {
    value = aws_instance.web.id
}

output arn {
    value = aws_instance.web.arn
}

output public_ip {
    value = aws_instance.web.public_ip
}

output private_ip {
    value = aws_instance.web.private_ip
}


output web2_id {
    value = aws_instance.web2.id
}



output sec_group_arn {
    value = aws_security_group.class2.arn
}

output sec_group_desc {
    value = aws_security_group.class2.description
}
