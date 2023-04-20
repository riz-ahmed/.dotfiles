local status_comment, comment = pcall(require, "Comment")
if not status_comment then
    print("comment didn't work!")
    return
end

comment.setup()
