function [A B n_user n_item] = makeData(matrix, user, item)
    [m_item m_user] = size(matrix);
    index_item = m_item - item + 1;
    index_user = m_user - user + 1;
    B = matrix(index_item:m_item,index_user:m_user);
    n_user = user;
    n_item = item;
    A = matrix;
    A(index_item:m_item,index_user:m_user) = 0;
end